//
//  UIFastDefine.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/27.
//

import UIKit

public class UIFastDefine<T: UIView> {
    var fastDefines: [UIFastDefine] = []
    public var define: ((_ view: T) -> Void)?
    
    public init(_ define: ((_ view: T) -> Void)? = nil) {
        self.define = define
    }
    
    public init(_ fastDefines: [UIFastDefine], _ define: ((_ view: T) -> Void)? = nil) {
        self.fastDefines = fastDefines
        self.define = define
    }
    
    public init(_ fastDefine: UIFastDefine, _ define: ((_ view: T) -> Void)? = nil) {
        self.fastDefines = [fastDefine]
        self.define = define
    }
    
    public func apply(_ view: T) {
        fastDefines.forEach {$0.apply(view)}
        define?(view)
    }
}

public extension UIView {
    convenience init(_ fastDefine: UIFastDefine<UIView>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UIView>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UIView>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UIView>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UILabel {
    convenience init(_ fastDefine: UIFastDefine<UILabel>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UILabel>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UILabel>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UILabel>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UIButton {
    convenience init(_ fastDefine: UIFastDefine<UIButton>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UIButton>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UIButton>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UIButton>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UIImageView {
    convenience init(_ fastDefine: UIFastDefine<UIImageView>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UIImageView>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UIImageView>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UIImageView>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UICollectionView {
    convenience init(_ fastDefine: UIFastDefine<UICollectionView>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UICollectionView>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UICollectionView>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UICollectionView>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UITableView {
    convenience init(_ fastDefine: UIFastDefine<UITableView>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UITableView>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UITableView>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UITableView>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UISlider {
    convenience init(_ fastDefine: UIFastDefine<UISlider>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UISlider>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UISlider>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UISlider>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UISwitch {
    convenience init(_ fastDefine: UIFastDefine<UISwitch>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UISwitch>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UISwitch>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UISwitch>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UITextField {
    convenience init(_ fastDefine: UIFastDefine<UITextField>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UITextField>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UITextField>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UITextField>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}

public extension UITextView {
    convenience init(_ fastDefine: UIFastDefine<UITextView>) {
        self.init()
        fastDefine.apply(self)
    }
    
    convenience init(_ fastDefines: [UIFastDefine<UITextView>]) {
        self.init()
        fastDefines.forEach {$0.apply(self)}
    }
    
    func define(_ fastDefine: UIFastDefine<UITextView>) -> Self {
        fastDefine.apply(self)
        return self
    }
    
    func define(_ fastDefines: [UIFastDefine<UITextView>]) -> Self {
        fastDefines.forEach {$0.apply(self)}
        return self
    }
}
