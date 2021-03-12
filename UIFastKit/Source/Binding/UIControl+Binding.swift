//
//  UIControl+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit

public extension UIControl {
    @discardableResult
    func isEnabled(_ variable: Variable<Bool>) -> Self {
        variable.bind {[unowned self] (isEnabled) in
            self.isEnabled = isEnabled
            self.box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func isSelected(_ variable: Variable<Bool>) -> Self {
        variable.bind {[unowned self] (isSelected) in
            self.isSelected = isSelected
            self.box.markDirty()
        }
        return self
    }
}
