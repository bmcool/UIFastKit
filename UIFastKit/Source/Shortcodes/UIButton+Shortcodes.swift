//
//  UIButton+Shortcodes.swift
//  tradingapp
//
//  Created by 林季正 on 2017/9/28.
//  Copyright © 2017年 Capital. All rights reserved.
//

import UIKit

public typealias UIButtonTargetClosure = () -> Void

public class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

public extension UIButton {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func click(_ closure: @escaping UIButtonTargetClosure) -> Self {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
        return self
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure()
    }
}


public extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

public extension UIButton {
    @discardableResult
    func image(_ named: String) -> Self {
        guard let image = UIImage(named: named)?.withRenderingMode(.alwaysOriginal) else
        {
            return self
        }
        guard let imageHighlight = UIImage(named: named)?.alpha(0.3)?.withRenderingMode(.alwaysOriginal) else
        {
            return self
        }
        
        self.imageView?.contentMode = .scaleToFill
        
        self.setImage(image, for: .normal)
        self.setImage(imageHighlight, for: .highlighted)
        
        return self
    }
    
    @discardableResult
    func image(_ named: String, for controlState: UIControl.State = []) -> Self {
        guard let image = UIImage(named: named)?.withRenderingMode(.alwaysOriginal) else
        {
            return self
        }
        
        self.imageView?.contentMode = .scaleToFill
        
        self.setImage(image, for: controlState)
        
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, for controlState: UIControl.State = []) -> Self {
        self.imageView?.contentMode = .scaleToFill
        
        self.setImage(image, for: controlState)
        
        return self
    }
    
    @discardableResult
    func text(_ title: String?, for controlState: UIControl.State = []) -> Self {
        self.setTitle(title, for: controlState)
        return self
    }
    
    @discardableResult
    func fontSize(_ size: CGFloat) -> Self {
        self.titleLabel?.font =  UIFont(name: self.titleLabel?.font?.familyName ?? "HelveticaNeue", size: size)
        return self
    }
    
    @discardableResult
    func contentHorizontalAlignment(_ align: UIControl.ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = align
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor?, for controlState: UIControl.State = []) -> Self {
        self.setTitleColor(color, for: controlState)
        return self
    }
}