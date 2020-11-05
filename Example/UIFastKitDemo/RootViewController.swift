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
        
        rootFlexContainer.box.column
            .add(UIButton(btnDefine).text("SimpleViewController").click {[unowned self] in
                navigationController?.pushViewController(SimpleViewController(), animated: true)
            })
            .add(UIView().backgroundColor(.lightGray).box.height(1))
            .add(UIButton(btnDefine).text("TableViewController").click {[unowned self] in
                navigationController?.pushViewController(TableViewController(), animated: true)
            })
            .add(UIView().backgroundColor(.lightGray).box.height(1))
            .add(UIButton(btnDefine).text("ArticleViewController").click {[unowned self] in
                navigationController?.pushViewController(ArticleViewController(), animated: true)
            })
    }
}
