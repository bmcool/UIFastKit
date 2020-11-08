//
//  ViewController.swift
//  UIFastKitDemo
//
//  Created by 林季正 on 2020/10/22.
//

import UIKit
import UIFastKit
import PinLayout
import RxRelay

public class DebugLabel: UILabel {
    deinit {
        print("-- deinit --", text ?? "(Empty)")
    }
}

class SimpleViewController: UIFastViewController {
    let view1Hidden = BehaviorRelay<Bool>(value: false)
    let price = BehaviorRelay<String?>(value: nil)
    let date = BehaviorRelay<String?>(value: nil)

    deinit {
        print("-- deinit -- ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UIFastDefine<UILabel> {$0.color(.white)}
        let subtitleLabel = UIFastDefine<UILabel>(titleLabel) {$0.fontSize(10)}
        let infoTitleLabel = UIFastDefine<UILabel> {$0.fontSize(30)}
        let valueLabel = UIFastDefine<UILabel>([subtitleLabel, infoTitleLabel])

        rootFlexContainer.backgroundColor(.lightGray).box.column
            .add(
                UIView().backgroundColor(.hex("#ff000033")).isHidden(view1Hidden).box.height(40).rowReverse
                    .add(DebugLabel(titleLabel).text(price).backgroundColor(.hex("0000ff")))
                    .add(UILabel(subtitleLabel).text("2222").backgroundColor(.lightGray).box
                            .right(50%).height(20).width(80))
            )
            .add(
                UIView().box.height(50).row
                    .add(UILabel().define(subtitleLabel).text(price).backgroundColor(.systemPink).box.height(20).alignSelf(.center))
                    .add(UILabel(valueLabel).fontSizeToFit(true).text(date).backgroundColor(.rgba(100, 200, 100, 0.7)).box.minWidth(80).maxWidth(120))
                    .add(UILabel().text("kkkkk").backgroundColor(.rgba("255 240 124")))
            )
            .add(
                UIView(3).box.height(100).row
                    .add(UIButton().click({[unowned self] in
                        self.date.accept(Date().description)
                        self.view.setNeedsLayout()
                    }).text("aaaa").backgroundColor(.orange).box.grow(1))
                    .add(UILabel().text("bbbb").backgroundColor(.rgba("255, 0, 0, 0.1")).box.grow(2))
            )
        
        var c = 0
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {[weak self] (timer) in
            c += 1

            if c == 500 {
                self?.view1Hidden.accept(true)
            }
            if c == 800 {
                self?.view1Hidden.accept(false)
            }
            self?.price.accept("\(c)")
            self?.view.setNeedsLayout()
        }
    }
}

