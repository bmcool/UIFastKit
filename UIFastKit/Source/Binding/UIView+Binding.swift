//
//  UIView+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit

public extension UIView {
    @discardableResult
    func isDisplay(_ variable: Variable<Bool>) -> Self {
        variable.bind {[weak self] (isDisplay) in
            self?.box.display(isDisplay ? .flex : .none).markDirty()
        }
        return self
    }
    
    @discardableResult
    func isHidden(_ variable: Variable<Bool>) -> Self {
        variable.bind {[weak self] (isHidden) in
            self?.isHidden(isHidden)
        }
        return self
    }
    
    @discardableResult
    func alpha(_ variable: Variable<CGFloat>) -> Self {
        variable.bind {[weak self] (alpha) in
            self?.alpha(alpha)
        }
        return self
    }
    
    @discardableResult
    func backgroundColor(_ variable: Variable<UIColor?>) -> Self {
        variable.bind {[weak self] (backgroundColor) in
            self?.backgroundColor(backgroundColor)
        }
        return self
    }
    
    @discardableResult
    func borderColor(_ variable: Variable<UIColor?>) -> Self {
        variable.bind {[weak self] (borderColor) in
            self?.borderColor(borderColor)
        }
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ variable: Variable<Bool>) -> Self {
        variable.bind {[weak self] (isUserInteractionEnabled) in
            self?.isUserInteractionEnabled = isUserInteractionEnabled
        }
        return self
    }
}
