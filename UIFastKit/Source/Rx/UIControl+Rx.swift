//
//  UIControl+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

public extension UIControl {
    @discardableResult
    func isEnabled(_ relay: BehaviorRelay<Bool>) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.isEnabled)
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func isSelected(_ relay: BehaviorRelay<Bool>) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(to: self.rx.isSelected)
            .ignoreWarning()
        return self
    }
}
