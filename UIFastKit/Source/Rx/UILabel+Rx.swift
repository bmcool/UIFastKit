//
//  UILabel+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

public extension UILabel {
    @discardableResult
    func color(_ relay: BehaviorRelay<UIColor?>) -> Self {
        relay
            .bind(onNext: {[unowned self] (color) in
                self.color(color)
            })
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func text(_ relay: BehaviorRelay<String?>) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.text)
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func attributedText(_ relay: BehaviorRelay<NSAttributedString?>) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.attributedText)
            .ignoreWarning()
        return self
    }
}
