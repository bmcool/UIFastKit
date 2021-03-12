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



public final class Variable<Element> {
    private var listeners: [Listener] = []
    
    public typealias E = Element
    
    public typealias Callback = (E) -> Void
    
    public class Listener {
        public var receive: Callback?
        
        public init(_ receive: Callback?) {
            self.receive = receive
        }
    }
    
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
    
    public func bind(_ receive: @escaping Callback) {
        receive(_value)
        listeners.append(Listener(receive))
    }
    
    private func dispatchReceive() {
        for listener in listeners {
            listener.receive?(_value)
        }
    }
}
