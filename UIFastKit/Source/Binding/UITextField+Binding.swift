//
//  UITextField+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit

public extension UITextField {
    @discardableResult
    func color(_ variable: Variable<UIColor?>) -> Self {
        variable.bind {[weak self] (color) in
            self?.color(color).box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func text(_ variable: Variable<String?>) -> Self {
        variable.bind {[weak self] (text) in
            self?.text(text).box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func attributedText(_ variable: Variable<NSAttributedString?>) -> Self {
        variable.bind {[weak self] (attributedText) in
            self?.attributedText = attributedText
            self?.box.markDirty()
        }
        return self
    }
}
