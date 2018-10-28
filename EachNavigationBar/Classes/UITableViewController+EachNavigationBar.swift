// 
//  UITableViewController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/27.
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension UITableViewController {
    
    func addObserverForContentOffset() {
        _navigationBar.isUnrestoredWhenViewWillLayoutSubviews = true
        tableView.addObserver(
            self,
            forKeyPath: "contentOffset",
            options: .new,
            context: nil)
    }
    
    func adjustsTableViewContentInset() {
        guard !_navigationBar.isHidden else { return }
        if #available(iOS 11.0, *) {
            if !_navigationBar.isLargeTitleHidden,
                let navigationBar = navigationController?.navigationBar {
                _navigationBar.frame.size.width = navigationBar.frame.size.width
                _navigationBar.frame.size.height = navigationBar.frame.size.height + _navigationBar.extraHeight
            }
        }
        tableView.contentInset.top = _navigationBar.bounds.height
        tableView.scrollIndicatorInsets.top = _navigationBar.bounds.height
    }
    
    open override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentOffset",
            let tableView = object as? UITableView,
            self.tableView === tableView else { return }
        _navigationBar.frame.origin.y = tableView.contentOffset.y + UIApplication.shared.statusBarFrame.maxY
    }
}
