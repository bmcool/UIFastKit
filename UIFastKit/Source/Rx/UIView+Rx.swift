//
//  UIView+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

public extension UIView {
    @discardableResult
    func isHidden(_ relay: BehaviorRelay<Bool>) -> Self {
        relay
            .do(afterNext: {[unowned self] isHidden in
                self.box.display(isHidden ? .none : .flex).markDirty()
            })
            .bind(to: self.rx.isHidden)
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func alpha(_ relay: BehaviorRelay<CGFloat>) -> Self {
        relay
            .bind(to: self.rx.alpha)
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func backgroundColor(_ relay: BehaviorRelay<UIColor?>) -> Self {
        relay
            .bind(to: self.rx.backgroundColor)
            .ignoreWarning()
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ relay: BehaviorRelay<Bool>) -> Self {
        relay
            .bind(to: self.rx.isUserInteractionEnabled)
            .ignoreWarning()
        return self
    }
}
