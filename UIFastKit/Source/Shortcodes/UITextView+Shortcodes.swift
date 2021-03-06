//
//  UITextView+Shortcodes.swift
//  ipet2
//
//  Created by 林季正 on 2020/1/10.
//  Copyright © 2020 liqi. All rights reserved.
//

import UIKit
import UITextView_Placeholder

public extension UITextView {
    @discardableResult
    func color(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func color(_ color: String) -> Self {
        self.textColor = UIColor.string(color)
        return self
    }
    
    @discardableResult
    func color(_ color: Int) -> Self {
        self.textColor = UIColor.hex(color)
        return self
    }
    
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?, color: UIColor) -> Self {
        self.placeholder = placeholder
        self.placeholderColor = color
        return self
    }
    
    @discardableResult
    func placeholderColor(_ color: UIColor) -> Self {
        self.placeholderColor = color
        return self
    }
    
    @discardableResult
    func textAlign(_ textAlign: NSTextAlignment) -> Self {
        self.textAlignment = textAlign
        return self
    }
    
    @discardableResult
    func fontFamilyName(_ familyName: String) -> Self {
        self.font = UIFont(name: familyName, size: self.font?.pointSize ?? 14)
        return self
    }
    
    @discardableResult
    func fontWeight(_ fontWeight: UIFont.Weight) -> Self {
        self.font = UIFont.systemFont(ofSize: self.font?.pointSize ?? 14, weight: fontWeight)
        return self
    }
    
    @discardableResult
    func fontSize(_ size: CGFloat) -> Self {
        self.font = UIFont(name: self.font?.familyName ?? "HelveticaNeue", size: size)
        return self
    }
    
    @discardableResult
    func isSecureTextEntry(_ secure: Bool) -> Self {
        self.isSecureTextEntry = secure
        return self
    }
}

