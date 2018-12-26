// 
//  BackBarButtonItem.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/20
//  Copyright © 2018年 Pircate. All rights reserved.
//

public struct BackBarButtonItem {
    
    var style: Style = .none
    
    var tintColor: UIColor?
    
    var needsDuplicate: Bool = false
    
    public var willBack: () -> Void = {}
    
    public var didBack: () -> Void = {}
    
    public enum Style {
        case none
        case title(String?)
        case image(UIImage?)
        case custom(UIButton)
    }
    
    public init(style: Style, tintColor: UIColor? = nil) {
        self.style = style
        self.tintColor = tintColor
    }
    
    func makeBarButtonItem(_ target: Any, action: Selector) -> UIBarButtonItem? {
        switch style {
        case .none:
            return nil
        case .title(let title):
            let backBarButtonItem = UIBarButtonItem(
                title: title,
                style: .plain,
                target: target,
                action: action)
            backBarButtonItem.tintColor = tintColor
            return backBarButtonItem
        case .image(let image):
            let backBarButtonItem = UIBarButtonItem(
                image: image,
                style: .plain,
                target: target,
                action: action)
            backBarButtonItem.tintColor = tintColor
            return backBarButtonItem
        case .custom(let button):
            guard needsDuplicate else {
                button.addTarget(target, action: action, for: .touchUpInside)
                button.tintColor = tintColor
                return UIBarButtonItem(customView: button)
            }
            guard let customView = button.duplicate() else { return nil }
            customView.addTarget(target, action: action, for: .touchUpInside)
            customView.tintColor = tintColor
            return UIBarButtonItem(customView: customView)
        }
    }
}
