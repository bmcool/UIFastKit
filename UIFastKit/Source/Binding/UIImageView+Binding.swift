//
//  UIImageView+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import SDWebImage

public extension UIImageView {
    @discardableResult
    func image(_ variable: Variable<String>) -> Self {
        variable.bind {[weak self] (named) in
            self?.image(named).box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func image(_ variable: Variable<UIImage?>) -> Self {
        variable.bind {[weak self] (image) in
            self?.image(image).box.markDirty()
        }
        return self
    }
    
    @discardableResult
    func image(_ variable: Variable<URL?>) -> Self {
        variable.bind {[weak self] (url) in
            self?.sd_setImage(with: url, completed: { (_, _, _, _) in
                self?.box.markDirty()
            })
        }
        return self
    }
}
