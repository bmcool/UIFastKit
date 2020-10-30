//
//  UIImageView+Shortcodes.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/27.
//

import UIKit

public extension UIImageView {
    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    @discardableResult
    func image(_ named: String) -> Self {
        self.image(UIImage(named: named))
        return self
    }
}
