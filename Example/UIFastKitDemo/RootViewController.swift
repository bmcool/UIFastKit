//
//  RootViewController.swift
//  UIFastKitDemo
//
//  Created by 林季正 on 2020/10/29.
//

import UIKit
import UIFastKit

class RootViewController: UIFastViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let btnDefine = UIFastDefine<UIButton> {
            $0.color(.black).size(UIScreen.width, 30)
        }
        
        [SimpleViewController.self, TableViewController.self, ArticleViewController.self].forEach {[unowned self] vcClass in
            rootFlexContainer.box.column
                .add(UIButton(btnDefine).text(vcClass.className).click {[unowned self] in
                    self.navigationController?.pushViewController(vcClass.init(), animated: true)
                })
                .add(UIView().backgroundColor(.lightGray).box.height(1))
        }
    }
}
