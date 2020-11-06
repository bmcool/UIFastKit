//
//  NameDescribable.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/6.
//

import Foundation

public protocol NameDescribable {
    var className: String { get }
    static var className: String { get }
}

public extension NameDescribable {
    var className: String {
        return String(describing: type(of: self))
    }

    static var className: String {
        return String(describing: self)
    }
}

// Extend with class/struct/enum...
extension NSObject: NameDescribable {}
extension Array: NameDescribable {}
