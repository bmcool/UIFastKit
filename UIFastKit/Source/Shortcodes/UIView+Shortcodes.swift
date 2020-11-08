//
//  UIView+Shortcodes.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/27.
//

import UIKit

public enum UIViewAlign: Int {
    case center
    case leftTop
    case centerTop
    case rightTop
    case leftCenter = 4
    case rightCenter = 5
    case leftBottom = 6
    case rightBottom = 7
    case centerBottom = 8
    
    var viewAnchor: CGPoint {
        switch self {
        case .center: return CGPoint(x: 0.5, y: 0.5)
        case .leftTop: return CGPoint(x: 0, y: 0)
        case .centerTop: return CGPoint(x: 0.5, y: 0)
        case .rightTop: return CGPoint(x: 1, y: 0)
        case .leftCenter: return CGPoint(x: 0, y: 0.5)
        case .rightCenter: return CGPoint(x: 1, y: 0.5)
        case .leftBottom: return CGPoint(x: 0, y: 1)
        case .rightBottom: return CGPoint(x: 1, y: 1)
        case .centerBottom: return CGPoint(x: 0.5, y: 1)
        }
    }
}

public extension UIView {
    var width: CGFloat {
        get {
            return bounds.width
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.height
        }
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: String) -> Self {
        self.backgroundColor = UIColor.string(color)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: Int) -> Self {
        self.backgroundColor = UIColor.hex(color)
        return self
    }
    
    @discardableResult
    @objc func size(_ width: CGFloat, _ height: CGFloat) -> Self {
        self.bounds = CGRectMake(0, 0, width, height)
        return self
    }
    
    @discardableResult
    func pos(_ x: CGFloat, _ y: CGFloat) -> Self {
        self.center = CGPoint(x: x, y: y)
        return self
    }
    
    @discardableResult
    func pos(_ point: CGPoint) -> Self {
        self.center = point
        return self
    }
    
    @discardableResult
    func align(_ align: UIViewAlign) -> Self {
        self.layer.anchorPoint = align.viewAnchor
        return self
    }
    
    @discardableResult
    func align(_ align: UIViewAlign, _ x: CGFloat, _ y: CGFloat) -> Self {
        return self.align(align).pos(x, y)
    }
    
    @discardableResult
    func align(_ align: UIViewAlign, _ point: CGPoint) -> Self {
        return self.align(align).pos(point)
    }
    
    @discardableResult
    func addTo(_ v: UIView) -> Self {
        v.addSubview(self)
        return self
    }
    
    @discardableResult
    func borderWidth(_ w: CGFloat) -> Self {
        self.layer.borderWidth = w
        return self
    }
    
    @discardableResult
    func borderColor(_ color: UIColor?) -> Self {
        self.layer.borderColor = color?.cgColor
        return self
    }
    
    @discardableResult
    func borderColor(_ color: String) -> Self {
        self.layer.borderColor = UIColor.string(color)?.cgColor
        return self
    }
    
    @discardableResult
    func borderColor(_ color: Int) -> Self {
        self.layer.borderColor = UIColor.hex(color)?.cgColor
        return self
    }
    
    @discardableResult
    func cornerRadius(_ r: CGFloat) -> Self {
        self.layer.cornerRadius = r
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
}

func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}
