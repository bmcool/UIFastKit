//
//  UIFastViewController.swift
//  UIFastKit
//
//  Created by 林季正 on 2020/11/5.
//

import UIKit
import FlexLayout

public class RootFlexContainer: UIView {
    weak var viewController: UIFastViewController?
}

open class UIFastViewController: UIViewController {
    public let rootScrollView = UIScrollView()
    
    public let rootFlexContainer = RootFlexContainer()
    public var rootLayoutMode = Flex.LayoutMode.adjustHeight

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        rootFlexContainer.viewController = self
        
        view.addSubview(rootScrollView)
        rootScrollView.addSubview(rootFlexContainer)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootScrollView.pin.all(view.pin.safeArea)
        switch rootLayoutMode {
        case .adjustHeight: rootFlexContainer.pin.left().top().right()
        case .adjustWidth: rootFlexContainer.pin.left().top().bottom()
        case .fitContainer: rootFlexContainer.pin.all()
        }
        rootFlexContainer.box.layout(mode: rootLayoutMode)
        rootScrollView.contentSize = rootFlexContainer.frame.size
    }
}

public extension RootFlexContainer {
    @discardableResult
    func layout(_ mode: Flex.LayoutMode = .adjustHeight) -> Self {
        viewController?.rootLayoutMode = mode
        return self
    }
}
