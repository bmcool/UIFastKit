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
    func fontSize(_ size: CGFloat) -> Self {
        self.font = UIFont(name: self.font?.familyName ?? "HelveticaNeue", size: size)
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
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
}
