// 
//  UITableViewController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/27.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    private var observation: NSKeyValueObservation {
        let observer = withUnsafePointer(to: &AssociatedKeys.observation) {
            objc_getAssociatedObject(self, $0) as? NSKeyValueObservation
        }
        
        if let observer {
            return observer
        }
        
        let observation = tableView.observe(
            \.contentOffset,
            options: .new
        ) { [weak self] tableView, _ in
            guard let `self` = self else { return }
            
            self.view.bringSubviewToFront(self._navigationBar)
            self._navigationBar.frame.origin.y = tableView.contentOffset.y + self._navigationBar.barMinY
        }
        
        withUnsafePointer(to: &AssociatedKeys.observation) {
            objc_setAssociatedObject(
                self,
                $0,
                observation,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
        
        return observation
    }
    
    func observeContentOffset() {
        _navigationBar.automaticallyAdjustsPosition = false
        
        _ = observation
    }
}
