//
//  List+Extensions.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/6.
//

import Foundation

public extension Int {
    var list: ClosedRange<Int> {
        return 1...self
    }
}

public extension Double {
    var list: ClosedRange<Int> {
        return 1...Int(self)
    }
}
