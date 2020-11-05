//
//  UIScreen+Shortcodes.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/6.
//

import UIKit

public extension UIScreen {
    static var width: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    
    static var height: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
}
