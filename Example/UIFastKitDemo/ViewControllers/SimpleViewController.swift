//
//  ViewController.swift
//  UIFastKitDemo
//
//  Created by 林季正 on 2020/10/22.
//

import UIKit
import UIFastKit
import PinLayout

public class DebugLabel: UILabel {
    deinit {
        print("-- deinit --", text ?? "(Empty)")
    }
}

class SimpleViewController: UIFastViewController {
    let view1Display = Variable<Bool>(false)
    let price = Variable<String?>(nil)
    let date = Variable<String?>(nil)
    let channel = Channel<String?>()
    
    let groupResult1 = Variable<String?>(nil)
    let groupResult2 = Variable<String?>(nil)
    let groupResult3 = Variable<String?>(nil)
    
    let group1 = UIFastButtonSingleChoice()
    let group2 = UIFastButtonSingleOptionalChoice()
    let group3 = UIFastButtonMultipleChoice()

    deinit {
        print("-- deinit -- ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UIFastDefine<UILabel> {$0.color(.white)}
        let subtitleLabel = UIFastDefine<UILabel>(titleLabel) {$0.fontSize(10)}
        let infoTitleLabel = UIFastDefine<UILabel> {$0.fontSize(30)}
        let valueLabel = UIFastDefine<UILabel>([subtitleLabel, infoTitleLabel])

        let channelLabel = DebugLabel(titleLabel)
        
        let groupButton = UIFastDefine<UIButton>() {
            $0.backgroundColor(.gray, for: [.normal])
                .backgroundColor(.blue, for: [.selected])
                .cornerRadius(15)
                .box.grow(1).all(5)
        }
        
        rootFlexContainer.backgroundColor(.lightGray).box.column
            .add(
                UIView().backgroundColor("#ff0000").isDisplay(view1Display).box.height(40).rowReverse
                    .add(DebugLabel(titleLabel).text(price).backgroundColor("0000ff"))
                    .add(UILabel(subtitleLabel).text("2222").backgroundColor("rgb 153 82 41 0.5").box
                            .right(50%).height(20).width(80))
            )
            .add(
                UIView().box.height(50).row
                    .add(UILabel().define(subtitleLabel).text(price).backgroundColor("0,200,200,0.7").box.height(20).alignSelf(.center))
                    .add(UILabel(valueLabel).fontSizeToFit(true).text(date).backgroundColor("100, 200, 100, 0.7").box.minWidth(80).maxWidth(120))
                    .add(UILabel().text("kkkkk").backgroundColor("255 240 124"))
                    .add(channelLabel.backgroundColor("0000ff").box.height(30).alignSelf(.center))
            )
            .add(
                UIView(3).box.height(100).row
                    .add(UIButton().click({[unowned self] in
                        self.date.value = Date().description
                        self.view.setNeedsLayout()
                    }).text("aaaa").backgroundColor(.orange).box.grow(1))
                    .add(UILabel().text("bbbb").backgroundColor("255, 0, 0, 0.1").box.grow(2))
            )
            .add(
                UIView().box.height(50).row
                    .add(UIButton(groupButton).group(group1).text("1111"))
                    .add(UIButton(groupButton).group(group1).text("2222"))
                    .add(UIButton(groupButton).group(group1).text("3333"))
            )
            .add(
                UIView().box.height(50).row
                    .add(UIButton(groupButton).group(group2).text("1111"))
                    .add(UIButton(groupButton).group(group2).text("2222"))
                    .add(UIButton(groupButton).group(group2).text("3333"))
            )
            .add(
                UIView().box.height(50).row
                    .add(UIButton(groupButton).group(group3).text("1111"))
                    .add(UIButton(groupButton).group(group3).text("2222"))
                    .add(UIButton(groupButton).group(group3).text("3333"))
            )
        
        group1.onSelectedIndexChanged { (index, buttons, group) in
            print(index, buttons.count)
        }
        group2.onSelectedIndexChanged { (index, buttons, group) in
            print(index, buttons.count)
        }
        group3.onSelectedIndexesChanged { (indexes, buttons, group) in
            print(indexes, buttons.count)
        }
        group1.selectedIndex = 1
        group2.selectedIndex = 2
        group3.selectedIndexes = [1, 2]

        
        let unlisten = channel.bind {[weak self] (v) in
            channelLabel.text(v).box.markDirty()
            self?.view.setNeedsLayout()
        }
        
        var c = 0
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {[weak self] (timer) in
            c += 1
            self?.view1Display.value = (c % 1000) > 500
            self?.price.value = "\(c)"
            self?.channel.send("\(c)")
            self?.view.setNeedsLayout()
            if c == 500 {
                unlisten()
            }
        }
    }
}

