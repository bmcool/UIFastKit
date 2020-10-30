//
//  UIButton+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

public extension UIButton {
    @discardableResult
    func textColor(_ relay: BehaviorRelay<UIColor?>, for controlState: UIControl.State = []) -> Self {
        relay
            .bind(onNext: {[unowned self] (color) in
                self.color(color, for: controlState)
            })
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func attributedText(_ relay: BehaviorRelay<NSAttributedString?>, for controlState: UIControl.State = []) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.attributedTitle(for: controlState))
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func text(_ relay: BehaviorRelay<String?>, for controlState: UIControl.State = []) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.title(for: controlState))
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func image(_ relay: BehaviorRelay<String>, for controlState: UIControl.State = []) -> Self {
        relay
            .bind(onNext: {[unowned self] (named) in
                self.image(named, for: controlState)
            })
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func image(_ relay: BehaviorRelay<UIImage?>, for controlState: UIControl.State = []) -> Self {
        relay
            .bind(onNext: {[unowned self] (image) in
                self.image(image, for: controlState)
            })
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func backgroundImage(_ relay: BehaviorRelay<UIImage?>, for controlState: UIControl.State = []) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.backgroundImage(for: controlState))
            .ignoreWarning()
        return self
    }
}
