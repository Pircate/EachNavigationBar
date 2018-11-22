// 
//  EachNavigationBar+Configuration.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/11/22
//  Copyright © 2018年 Pircate. All rights reserved.
//

extension EachNavigationBar {
    
    func setup(with configuration: Configuration) {
        isHidden = configuration.isHidden
        alpha = configuration.alpha
        barTintColor = configuration.barTintColor
        shadowImage = configuration.shadowImage
        isShadowHidden = configuration.isShadowHidden
        titleTextAttributes = configuration.titleTextAttributes
        setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        isTranslucent = configuration.isTranslucent
        barStyle = configuration.barStyle
        statusBarStyle = configuration.statusBarStyle
        extraHeight = configuration.extraHeight
        if #available(iOS 11.0, *) {
            prefersLargeTitles = configuration.prefersLargeTitles
            largeTitleTextAttributes = configuration.largeTitleTextAttributes
        }
    }
}
