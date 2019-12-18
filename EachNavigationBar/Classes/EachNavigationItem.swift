// 
//  EachNavigationItem.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2019/12/18.
//  Copyright © 2019年 Pircate. All rights reserved.
//

class EachNavigationItem: UINavigationItem {
    
    private weak var viewController: UIViewController?
    
    convenience init(viewController: UIViewController?) {
        self.init()
        
        self.viewController = viewController
    }
    
    override var title: String? {
        didSet { viewController?.navigationItem.title = title }
    }
    
    @available(iOS 11.0, *)
    override var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        get { super.largeTitleDisplayMode }
        set {
            super.largeTitleDisplayMode = newValue
            
            viewController?.navigationItem.largeTitleDisplayMode = newValue
        }
    }
}
