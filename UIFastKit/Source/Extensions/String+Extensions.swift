//
//  String+Extensions.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/8.
//

import Foundation

public extension String {
    var isNumeric: Bool {
        return Double(self) != nil
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
}
