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

public typealias Cancelable = () -> Void

public protocol Bindable {
    associatedtype Element

    func bind(_ receive: @escaping (Element) -> Void) -> Cancelable

    func send(_ value: Element)
}

public protocol HasValue {
    associatedtype Element

    var value: Element { get set }
}

public class Binding {
    @discardableResult
    public static func group<T1, T2>(
        var1: Variable<T1?>,
        var2: Variable<T2?>,
        _ receive: @escaping (T1, T2) -> Void) -> Cancelable {
        let doReceive = {
            if var1.value != nil && var2.value != nil {
                receive(var1.value!, var2.value!)
            }
        }
        let unbinding1 = var1.bind { _ in doReceive() }
        let unbinding2 = var2.bind { _ in doReceive() }
        
        return {
            unbinding1()
            unbinding2()
        }
    }
    
    @discardableResult
    public static func group<T1, T2, T3>(
        var1: Variable<T1?>,
        var2: Variable<T2?>,
        var3: Variable<T3?>,
        _ receive: @escaping (T1, T2, T3) -> Void) -> Cancelable {
        let doReceive = {
            if var1.value != nil && var2.value != nil && var3.value != nil {
                receive(var1.value!, var2.value!, var3.value!)
            }
        }
        let unbinding1 = var1.bind { _ in doReceive() }
        let unbinding2 = var2.bind { _ in doReceive() }
        let unbinding3 = var3.bind { _ in doReceive() }

        return {
            unbinding1()
            unbinding2()
            unbinding3()
        }
    }
    
    @discardableResult
    public static func group<T1, T2, T3, T4>(
        var1: Variable<T1?>,
        var2: Variable<T2?>,
        var3: Variable<T3?>,
        var4: Variable<T4?>,
        _ receive: @escaping (T1, T2, T3, T4) -> Void) -> Cancelable {
        let doReceive = {
            if var1.value != nil && var2.value != nil && var3.value != nil && var4.value != nil {
                receive(var1.value!, var2.value!, var3.value!, var4.value!)
            }
        }
        let unbinding1 = var1.bind { _ in doReceive() }
        let unbinding2 = var2.bind { _ in doReceive() }
        let unbinding3 = var3.bind { _ in doReceive() }
        let unbinding4 = var4.bind { _ in doReceive() }

        return {
            unbinding1()
            unbinding2()
            unbinding3()
            unbinding4()
        }
    }
}

public class Channel<Element>: Bindable {
    internal var listeners: [String: Listener] = [:]

    internal class Listener {
        public var receive: ((Element) -> Void)?
        
        public init(_ receive: ((Element) -> Void)?) {
            self.receive = receive
        }
    }
    
    public init() { }
    
    @discardableResult
    public func bind(_ receive: @escaping (Element) -> Void) -> Cancelable {
        let listener = Listener(receive)
        let address = "\(Unmanaged.passUnretained(listener).toOpaque())"
        listeners[address] = listener
        return {[weak self] in
            self?.listeners.removeValue(forKey: address)
        }
    }
    
    public func send(_ value: Element) {
        for listener in listeners.values {
            listener.receive?(value)
        }
    }
    
    public func asVariable() -> Variable<Element?> {
        let ov = Variable<Element?>(nil)
        bind { value in
            ov.value = value
        }
        return ov
    }
}

public class Variable<Element>: Bindable, HasValue {
    private var _channel = Channel<Element>()
    
    internal var _lock = SpinLock()

    internal var _value: Element
    
    public var value: Element {
        get {
            _lock.lock(); defer { _lock.unlock() }
            return _value
        }
        set(newValue) {
            _lock.lock()
            _value = newValue
            _lock.unlock()
            _channel.send(_value)
        }
    }
    
    public init(_ value: Element) {
        _value = value
    }
    
    @discardableResult
    public func bind(_ receive: @escaping (Element) -> Void) -> Cancelable {
        receive(value)
        return _channel.bind(receive)
    }
    
    public func send(_ value: Element) {
        _channel.send(value)
    }
    
    public var channel: Channel<Element> {
        get {
            return _channel
        }
    }
}

public final class OptionalVariable<Element>: Variable<Element?> {
    override public var value: Element? {
        get {
            let v = super.value
            return v
        }
        set(newValue) {
            super.value = newValue
        }
    }
}

public final class FlashVariable<Element>: Variable<Element?> {
    override public var value: Element? {
        get {
            let v = super.value
            _value = nil
            return v
        }
        set(newValue) {
            super.value = newValue
        }
    }
}
