// 
//  BackBarButtonItem.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/20
//  Copyright © 2018年 Pircate. All rights reserved.
//

@objcMembers
open class BackBarButtonItem: NSObject {
    
    public static let none: BackBarButtonItem = .init(style: .none)
    
    public var shouldBack: (BackBarButtonItem) -> Bool = { _ in true }
    
    public var willBack: () -> Void = {}
    
    public var didBack: () -> Void = {}
    
    weak var navigationController: UINavigationController?
    
    var needsDuplicate: Bool = false
    
    var style: Style = .none
    
    var tintColor: UIColor?
    
    public init(style: Style, tintColor: UIColor? = nil) {
        self.style = style
        self.tintColor = tintColor
    }
}

extension BackBarButtonItem {
    
    public enum Style {
        case none
        case title(String?)
        case image(UIImage?)
        case custom(UIButton)
    }
}

extension BackBarButtonItem {
    
    @objc public func goBack() {
        navigationController?.popViewController(animated: true)
    }
 
    func makeBarButtonItem() -> UIBarButtonItem? {
        let action = #selector(backBarButtonItemAction)
        
        switch style {
        case .none:
            return nil
        case .title(let title):
            let backBarButtonItem = UIBarButtonItem(
                title: title,
                style: .plain,
                target: self,
                action: action)
            backBarButtonItem.tintColor = tintColor
            
            return backBarButtonItem
        case .image(let image):
            let backBarButtonItem = UIBarButtonItem(
                image: image,
                style: .plain,
                target: self,
                action: action)
            backBarButtonItem.tintColor = tintColor
            
            return backBarButtonItem
        case .custom(let button):
            guard needsDuplicate else {
                button.addTarget(self, action: action, for: .touchUpInside)
                button.tintColor = tintColor
                return UIBarButtonItem(customView: button)
            }
            
            guard let customView = button.duplicate() else { return nil }
            customView.addTarget(self, action: action, for: .touchUpInside)
            customView.tintColor = tintColor
            return UIBarButtonItem(customView: customView)
        }
    }
    
    @objc private func backBarButtonItemAction() {
        guard shouldBack(self) else { return }
        
        willBack()
        goBack()
        didBack()
    }
}
