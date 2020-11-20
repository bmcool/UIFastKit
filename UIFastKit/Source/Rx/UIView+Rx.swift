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
    func isDisplay(_ relay: BehaviorRelay<Bool>) -> Self {
        relay
            .bind(onNext: {[unowned self] isDisplay in
                self.box.display(isDisplay ? .flex : .none).markDirty()
            })
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func isHidden(_ relay: BehaviorRelay<Bool>) -> Self {
        relay
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
