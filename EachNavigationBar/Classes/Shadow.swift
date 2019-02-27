// 
//  Shadow.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2019/2/27
//  Copyright © 2019年 Pircate. All rights reserved.
//

public class Shadow: NSObject {
    let color: CGColor?
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
    let path: CGPath?
    
    @objc public static let none: Shadow = .init()
    
    @objc public init(
        color: CGColor? = nil,
        opacity: Float = 0,
        offset: CGSize = CGSize(width: 0, height: -3),
        radius: CGFloat = 3,
        path: CGPath? = nil) {
        self.color = color
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
        self.path = path
    }
}
