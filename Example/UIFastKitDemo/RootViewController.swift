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
        
        [SimpleViewController(), TableViewController(), ArticleViewController()].forEach {[unowned self] vc in
            rootFlexContainer.box.column
                .add(UIButton(btnDefine).text(vc.className).click {[unowned self] in
                    navigationController?.pushViewController(vc, animated: true)
                })
                .add(UIView().backgroundColor(.lightGray).box.height(1))
        }
    }
}
