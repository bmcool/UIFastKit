//
//  UILabel+Shortcodes.swift
//  tradingapp
//
//  Created by 林季正 on 2017/9/27.
//  Copyright © 2017年 Capital. All rights reserved.
//

import UIKit

public extension UILabel {
    @discardableResult
    func fontSizeToFit(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.baselineAdjustment = .alignCenters
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
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
        self.font = UIFont(name: self.font?.familyName ?? UIFont.systemFont(ofSize: size).familyName, size: size)
        return self
    }
    
    @discardableResult
    func textAlign(_ textAlign: NSTextAlignment) -> Self {
        self.textAlignment = textAlign
        return self
    }
    
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
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> Self {
        self.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func strikeThrough(_ isStrikeThrough:Bool) -> Self {
        if isStrikeThrough {
            if let lblText = self.text {
                let attributeString =  NSMutableAttributedString(string: lblText)
                attributeString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
                self.attributedText = attributeString
            }
        } else {
            if let attributedStringText = self.attributedText {
                let txt = attributedStringText.string
                self.attributedText = nil
                self.text = txt
            }
        }
        return self
    }
}

public extension UILabel {
    convenience init(_ text: String) {
        self.init()
        self.text(text)
    }
}
