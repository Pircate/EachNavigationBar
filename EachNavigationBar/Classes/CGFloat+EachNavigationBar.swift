// 
//  CGFloat+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/11/20
//  Copyright © 2018年 Pircate. All rights reserved.
//

import Foundation

extension CGFloat {
    
    struct StatusBar {
        static var maxY: CGFloat {
            return UIApplication.shared.statusBarFrame.maxY
        }
    }
    
    struct NavigationBar {
        static let height: CGFloat = 44.0
    }
    
    struct LargeTitle {
        
        private static let minimumHeight: CGFloat = 49.0
        
        static func height(for largeTitleTextAttributes: [NSAttributedString.Key : Any]?) -> CGFloat {
            guard let largeTitleTextAttributes = largeTitleTextAttributes,
                let font = largeTitleTextAttributes[.font] as? UIFont else {
                    return CGFloat.LargeTitle.minimumHeight
            }
            let size = font.pointSize * 1.2
            return size > CGFloat.LargeTitle.minimumHeight ? size : CGFloat.LargeTitle.minimumHeight
        }
    }
}
