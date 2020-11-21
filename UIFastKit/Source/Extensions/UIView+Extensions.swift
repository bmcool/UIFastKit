//
//  UIView+Extensions.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/6.
//

import UIKit

public extension UIView {
    func subviews(_ tag: Int) -> [UIView] {
        return subviews.filter {$0.tag == tag}
    }
    
    @discardableResult
    func removeSubviews(_ tag: Int) -> Self {
        subviews(tag).forEach {$0.removeFromSuperview()}
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
}
