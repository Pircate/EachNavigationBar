// 
//  BackBarButtonItem.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/20
//  Copyright © 2018年 Pircate. All rights reserved.
//

open class BackBarButtonItem: UIBarButtonItem {
    
    public var shouldBack: (BackBarButtonItem) -> Bool = { _ in true }
    
    public var willBack: () -> Void = {}
    
    public var didBack: () -> Void = {}
    
    weak var navigationController: UINavigationController?
}

public extension BackBarButtonItem {
    
    convenience init(style: ItemStyle, tintColor: UIColor? = nil) {
        let action = #selector(backBarButtonItemAction)
        
        switch style {
        case .title(let title):
            self.init(title: title, style: .plain, target: nil, action: action)
            
            self.target = self
            self.tintColor = tintColor
        case .image(let image):
            self.init(image: image, style: .plain, target: nil, action: action)
            
            self.target = self
            self.tintColor = tintColor
        case .custom(let button):
            self.init(customView: button)
            
            button.addTarget(self, action: action, for: .touchUpInside)
            button.tintColor = tintColor
        }
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension BackBarButtonItem {
    
    public enum ItemStyle {
        case title(String?)
        case image(UIImage?)
        case custom(UIButton)
    }
}

extension BackBarButtonItem {
    
    @objc private func backBarButtonItemAction() {
        guard shouldBack(self) else { return }
        
        willBack()
        goBack()
        didBack()
    }
}
