//
//  ScrollBinding.swift
//  Edwin
//
//  Created by 林季正 on 2021/3/16.
//

import UIFastKit

protocol UIFastScrollBindingContainerDataSource: class {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

class UIFastScrollBindingContainer: UIView {
    weak var dataSource: UIFastScrollBindingContainerDataSource? {
        didSet {
            scrollBindingTableViews.forEach { (view) in
                view.dataSource = dataSource
            }
        }
    }

    var scrollBindingTableViews: [UIFastScrollBindingTableView] = [] {
        didSet {
            scrollBindingTableViews.forEach {[weak self] (view) in
                // disable auto-contentSize
                view.tableView.estimatedRowHeight = 0
                view.tableView.estimatedSectionHeaderHeight = 0
                view.tableView.estimatedSectionFooterHeight = 0
                
                view.container = self
                
                view.dataSource = dataSource
            }
        }
    }
    
    func syncScroll(_ tableView: UITableView) {
        scrollBindingTableViews.forEach { (tvc) in
            if tvc.tableView != tableView {
                tvc.tableView.contentOffset = tableView.contentOffset
            }
        }
    }
    
    func tableViewDidScroll(_ tableView: UITableView) {
        syncScroll(tableView)
    }
}

class UIFastScrollBindingTableView: UIView {
    let tableView = UITableView()
    
    var isScrolling = false
    
    weak var container: UIFastScrollBindingContainer?
    
    weak var dataSource: UIFastScrollBindingContainerDataSource?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource?.tableView(tableView, heightForRowAt: indexPath) ?? 0
    }
}

extension UIFastScrollBindingTableView: UITableViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        isScrolling = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            isScrolling = false
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrolling = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isScrolling {
            container?.tableViewDidScroll(tableView)
        }
    }
}

