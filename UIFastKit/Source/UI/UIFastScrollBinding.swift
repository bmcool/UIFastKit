//
//  ScrollBinding.swift
//  Edwin
//
//  Created by 林季正 on 2021/3/16.
//

import UIKit

open class UIFastTableViewScrollBinder {
    public init() { }
    
    public var scrollBindingTableViews: [UIFastScrollBindingTableView] = [] {
        didSet {
            scrollBindingTableViews.forEach {[weak self] (view) in
                // disable auto-contentSize
                view.tableView.estimatedRowHeight = 0
                view.tableView.estimatedSectionHeaderHeight = 0
                view.tableView.estimatedSectionFooterHeight = 0
                
                view.binder = self
            }
        }
    }
    
    func syncScroll(_ scrollView: UIScrollView) {
        scrollBindingTableViews.forEach { (tvc) in
            if tvc.tableView != scrollView {
                tvc.tableView.contentOffset = scrollView.contentOffset
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        syncScroll(scrollView)
    }
}

open class UIFastScrollBindingTableViewProxy: NSObject {
    var isScrolling = false
    
    public weak var binder: UIFastTableViewScrollBinder?
    
    public weak var delegate: UITableViewDelegate?
    
    open override func responds(to aSelector: Selector) -> Bool {
        return super.responds(to: aSelector) || delegate?.responds(to: aSelector) == true
    }

    open override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if delegate?.responds(to: aSelector) == true {
            return delegate
        } else {
            return super.forwardingTarget(for: aSelector)
        }
    }
}

extension UIFastScrollBindingTableViewProxy: UITableViewDelegate {
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            isScrolling = false
        }
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
        delegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrolling {
            binder?.scrollViewDidScroll(scrollView)
        }
        delegate?.scrollViewDidScroll?(scrollView)
    }
}

open class UIFastScrollBindingTableView: UIView {
    public let tableView = UITableView()
    
    private let defaultDelegate =  UIFastScrollBindingTableViewProxy()
    
    public weak var binder: UIFastTableViewScrollBinder? {
        didSet {
            defaultDelegate.binder = binder
        }
    }
    
    public weak var dataSource: UITableViewDataSource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    
    public weak var delegate: UITableViewDelegate? {
        didSet {
            defaultDelegate.delegate = delegate
            tableView.delegate = defaultDelegate
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        
        tableView.delegate = defaultDelegate
        
        addSubview(tableView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
    }
}
