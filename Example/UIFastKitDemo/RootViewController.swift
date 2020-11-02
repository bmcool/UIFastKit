//
//  RootViewController.swift
//  UIFastKitDemo
//
//  Created by 林季正 on 2020/10/29.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIButton()
            .text("push")
            .color(.black)
            .size(100, 30)
            .align(.center, view.frame.midX, view.frame.midY)
            .click {[unowned self] in
                self.navigationController?.pushViewController(ViewController(), animated: true)
            }
            .addTo(view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
