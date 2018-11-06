// 
//  UITableViewController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/27.
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension UITableViewController {
    
    @objc public func removeObserverForContentOffset() {
        tableView.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    func addObserverForContentOffset() {
        _navigationBar.isUnrestoredWhenViewWillLayoutSubviews = true
        tableView.addObserver(
            self,
            forKeyPath: "contentOffset",
            options: .new,
            context: nil)
    }
    
    func adjustsTableViewContentInset() {
        let inset: CGFloat
        if #available(iOS 11.0, *) {
            inset = tableView.contentInsetAdjustmentBehavior == .never ? 0 : statusBarMaxY
        } else {
            inset = automaticallyAdjustsScrollViewInsets ? statusBarMaxY : 0
        }
        let contentInsetTop = _navigationBar.frame.maxY - inset
        tableView.contentInset.top = contentInsetTop
        tableView.scrollIndicatorInsets.top = contentInsetTop
    }
    
    open override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
        guard keyPath == "contentOffset",
            let tableView = object as? UITableView,
            self.tableView === tableView else { return }
        _navigationBar.frame.origin.y = tableView.contentOffset.y + statusBarMaxY
    }
}
