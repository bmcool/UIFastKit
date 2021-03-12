//
//  UIImageView+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

public extension UIImageView {
    @discardableResult
    func image(_ variable: Variable<String>) -> Self {
        variable.bind {[unowned self] (named) in
            self.image(named).box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func image(_ variable: Variable<UIImage?>) -> Self {
        variable.bind {[unowned self] (image) in
            self.image(image).box.markDirty()
        }
        return self
    }
}
