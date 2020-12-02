// 
//  Const.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/11/20
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

extension CGFloat {
    
    static let navigationBarHeight: CGFloat = 44.0
    
    static var statusBarMaxY: CGFloat {
        if #available(iOS 13, *) {
            return UIApplication.shared
                .keyWindow?
                .windowScene?
                .statusBarManager?
                .statusBarFrame
                .maxY ?? 0
        }
        return UIApplication.shared.statusBarFrame.maxY
    }
}

extension UIEdgeInsets {
    
    static let barLayoutPaddings: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
    
    static let barLayoutMargins: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
}
