//
//  Variable.swift
//  UIFastKit
//
//  Created by 林季正 on 2021/3/11.
//

import Foundation

import class Foundation.NSRecursiveLock

#if TRACE_RESOURCES
    class RecursiveLock: NSRecursiveLock {
        override init() {
            _ = Resources.incrementTotal()
            super.init()
        }
        
        override func lock() {
            super.lock()
            _ = Resources.incrementTotal()
        }
        
        override func unlock() {
            super.unlock()
            _ = Resources.decrementTotal()
        }
        
        deinit {
            _ = Resources.decrementTotal()
        }
    }
#else
    typealias RecursiveLock = NSRecursiveLock
#endif


protocol Lock {
    func lock()
    func unlock()
}

// https://lists.swift.org/pipermail/swift-dev/Week-of-Mon-20151214/000321.html
typealias SpinLock = RecursiveLock

extension RecursiveLock : Lock {
    @inline(__always)
    final func performLocked(_ action: () -> Void) {
        lock(); defer { unlock() }
        action()
    }
    
    @inline(__always)
    final func calculateLocked<T>(_ action: () -> T) -> T {
        lock(); defer { unlock() }
        return action()
    }
    
    @inline(__always)
    final func calculateLockedOrFail<T>(_ action: () throws -> T) throws -> T {
        lock(); defer { unlock() }
        let result = try action()
        return result
    }
}

public class Binding<Element> {
    public var listeners: [String: Listener] = [:]
    
    public typealias E = Element
    
    public typealias Callback = (E) -> Void
    
    public class Listener {
        public var receive: Callback?
        
        public init(_ receive: Callback?) {
            self.receive = receive
        }
    }
    
    public init() { }
}

public final class Channel<Element>: Binding<Element> {
    public func send(_ value: E) {
        for listener in listeners.values {
            listener.receive?(value)
        }
    }
    
    @discardableResult
    public func listen(_ receive: @escaping Callback) -> (() -> Void) {
        let listener = Listener(receive)
        let address = "\(Unmanaged.passUnretained(listener).toOpaque())"
        listeners[address] = listener
        return {[weak self] in
            self?.listeners.removeValue(forKey: address)
        }
    }
}

public final class Variable<Element>: Binding<Element> {
    private var _lock = SpinLock()
    
    private var _value: E
    
    public var value: E {
        get {
            _lock.lock(); defer { _lock.unlock() }
            return _value
        }
        set(newValue) {
            _lock.lock()
            _value = newValue
            _lock.unlock()
            
            dispatchReceive()
        }
    }
    
    public init(_ value: Element) {
        _value = value
    }
    
    @discardableResult
    public func bind(_ receive: @escaping Callback) -> (() -> Void) {
        receive(_value)
        let listener = Listener(receive)
        let address = "\(Unmanaged.passUnretained(listener).toOpaque())"
        listeners[address] = listener
        return {[weak self] in
            self?.listeners.removeValue(forKey: address)
        }
    }
    
    private func dispatchReceive() {
        for listener in listeners.values {
            listener.receive?(_value)
        }
    }
}
