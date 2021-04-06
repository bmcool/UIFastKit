//
//  UIButton+Shortcodes.swift
//  tradingapp
//
//  Created by 林季正 on 2017/9/28.
//  Copyright © 2017年 Capital. All rights reserved.
//

import UIKit

public typealias ClickClosure = () -> Void

public typealias ClickClosureWithSender = (_ sender: UIButton) -> Void

public class ClosureWrapper: NSObject {
    let closure: ClickClosure
    init(_ closure: @escaping ClickClosure) {
        self.closure = closure
    }
}

public class SenderClosureWrapper: NSObject {
    let closure: ClickClosureWithSender
    init(_ closure: @escaping ClickClosureWithSender) {
        self.closure = closure
    }
}

public extension UIButton {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
        static var senderClosure = "senderClosure"
    }
    
    private var targetClosure: ClickClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var senderClosure: ClickClosureWithSender? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.senderClosure) as? SenderClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.senderClosure, SenderClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func click(_ closure: @escaping ClickClosure) -> Self {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
        return self
    }
    
    @discardableResult
    func click(_ closure: @escaping ClickClosureWithSender) -> Self {
        senderClosure = closure
        addTarget(self, action: #selector(UIButton.senderClosureAction), for: .touchUpInside)
        return self
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure()
    }
    
    @objc func senderClosureAction(_ sender: UIButton) {
        guard let senderClosure = senderClosure else { return }
        senderClosure(sender)
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
    func fontFamilyName(_ familyName: String) -> Self {
        self.titleLabel?.font = UIFont(name: familyName, size: self.titleLabel?.font?.pointSize ?? 14)
        return self
    }
    
    @discardableResult
    func fontWeight(_ fontWeight: UIFont.Weight) -> Self {
        self.titleLabel?.font = UIFont.systemFont(ofSize: self.titleLabel?.font?.pointSize ?? 14, weight: fontWeight)
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
    func titleEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = insets
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor?, for controlState: UIControl.State = []) -> Self {
        self.setTitleColor(color, for: controlState)
        return self
    }
    
    @discardableResult
    func color(_ color: String, for controlState: UIControl.State = []) -> Self {
        self.setTitleColor(UIColor.string(color), for: controlState)
        return self
    }
    
    @discardableResult
    func color(_ color: Int, for controlState: UIControl.State = []) -> Self {
        self.setTitleColor(UIColor.hex(color), for: controlState)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor?, for controlState: UIControl.State = []) -> Self {
        self.setBackgroundColor(color, for: controlState)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: String, for controlState: UIControl.State = []) -> Self {
        self.setBackgroundColor(UIColor.string(color), for: controlState)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: Int, for controlState: UIControl.State = []) -> Self {
        self.setBackgroundColor(UIColor.hex(color), for: controlState)
        return self
    }
    
    private func setBackgroundColor(_ color: UIColor?, for controlState: UIControl.State) {
        let c = color ?? .clear
        let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

        UIGraphicsBeginImageContext(minimumSize)

        if let context = UIGraphicsGetCurrentContext() {
          context.setFillColor(c.cgColor)
          context.fill(CGRect(origin: .zero, size: minimumSize))
        }

        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.clipsToBounds = true
        self.setBackgroundImage(colorImage, for: controlState)
    }
}
