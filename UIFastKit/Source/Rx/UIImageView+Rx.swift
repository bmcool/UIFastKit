//
//  UIImageView+Rx.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/10/30.
//

public extension UIImageView {
    @discardableResult
    func image(_ relay: BehaviorRelay<String>) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(onNext: {[unowned self] (named) in
                self.image(named)
            })
            .ignoreWarning()
        return self
    }
    
    @discardableResult
    func image(_ relay: BehaviorRelay<UIImage?>) -> Self {
        relay
            .do(afterNext: {[unowned self] _ in
                self.box.markDirty()
            })
            .bind(onNext: {[unowned self] (image) in
                self.image(image)
            })
            .ignoreWarning()
        return self
    }
}
