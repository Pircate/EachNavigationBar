//
//  Navigation.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/6/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

public struct Navigation<Base> {
    
    let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

public protocol NavigationCompatible {
    
    associatedtype CompatibleType
    
    var navigation: CompatibleType { get }
}

public extension NavigationCompatible {
    
    var navigation: Navigation<Self> {
        return Navigation(self)
    }
}

extension UIViewController: NavigationCompatible {}
