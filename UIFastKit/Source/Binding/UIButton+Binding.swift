//
//  UIButton+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit

public extension UIButton {
    @discardableResult
    func textColor(_ variable: Variable<UIColor?>, for controlState: UIControl.State = []) -> Self {
        variable.bind {[weak self] (color) in
            self?.color(color, for: controlState)
        }
        return self
    }
    
    @discardableResult
    func attributedText(_ variable: Variable<NSAttributedString?>, for controlState: UIControl.State = []) -> Self {
        variable.bind {[weak self] (attributedTitle) in
            self?.setAttributedTitle(attributedTitle, for: controlState)
            self?.box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func text(_ variable: Variable<String?>, for controlState: UIControl.State = []) -> Self {
        variable.bind {[weak self] (title) in
            self?.setTitle(title, for: controlState)
            self?.box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func image(_ variable: Variable<String>, for controlState: UIControl.State = []) -> Self {
        variable.bind {[weak self] (named) in
            self?.image(named, for: controlState)
            self?.box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func image(_ variable: Variable<UIImage?>, for controlState: UIControl.State = []) -> Self {
        variable.bind {[weak self] (image) in
            self?.image(image, for: controlState)
            self?.box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func backgroundImage(_ variable: Variable<UIImage?>, for controlState: UIControl.State = []) -> Self {
        variable.bind {[weak self] (backgroundImage) in
            self?.setBackgroundImage(backgroundImage, for: controlState)
            self?.box.markDirty()
        }
        return self
    }
}
