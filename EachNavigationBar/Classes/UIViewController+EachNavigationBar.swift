//
//  UIViewController+EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

extension UIViewController {

    func setupNavigationBarWhenViewDidLoad() {
        guard let navigationController = navigationController else { return }
        navigationController.sendNavigationBarToBack()
        
        if #available(iOS 11.0, *) {
            _navigationBar.prefersLargeTitles = navigationController.navigationBar.prefersLargeTitles
        }
        
        let configuration = navigationController._configuration
        _navigationBar.setup(with: configuration)
        
        setupBackBarButtonItem(navigationController)
        
        view.addSubview(_navigationBar)
    }
    
    private func setupBackBarButtonItem(_ navigationController: UINavigationController) {
        let count = navigationController.viewControllers.count
        guard count > 1 else { return }
        
        let backButton = UIButton(type: .system)
        let image = UIImage(named: "navigation_back_default", in: Bundle.current, compatibleWith: nil)
        backButton.setImage(image, for: .normal)
        
        if let title = navigationController.viewControllers[count - 2]._navigationItem.title {
            let maxWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 3
            let width = (title as NSString).boundingRect(
                with: CGSize(width: maxWidth, height: 20),
                options: NSStringDrawingOptions.usesFontLeading,
                attributes: [.font: UIFont.boldSystemFont(ofSize: 17)],
                context: nil).size.width
            backButton.setTitle(width < maxWidth ? title : "Back", for: .normal)
        } else {
            backButton.setTitle("Back", for: .normal)
        }
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        backButton.contentEdgeInsets = .init(top: 0, left: -8, bottom: 0, right: 8)
        backButton.sizeToFit()
    
        _navigationBar.backBarButtonItem = BackBarButtonItem(style: .custom(backButton))
    }
    
    func updateNavigationBarWhenViewWillAppear() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barStyle = _navigationBar._barStyle
        navigationBar.isHidden = _navigationBar.isHidden
        if #available(iOS 11.0, *) {
            adjustsSafeAreaInsetsAfterIOS11()
            navigationItem.title = _navigationItem.title
            navigationBar.largeTitleTextAttributes = _navigationBar.largeTitleTextAttributes
        }
        view.bringSubviewToFront(_navigationBar)
    }
}

extension UIViewController {
    
    public func adjustsNavigationBarLayout() {
        _navigationBar.adjustsLayout()
        _navigationBar.setNeedsLayout()
    }
    
    func adjustsSafeAreaInsetsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        let height = _navigationBar.additionalView?.frame.height ?? 0
        additionalSafeAreaInsets.top = _navigationBar.isHidden
            ? -view.safeAreaInsets.top
            : _navigationBar._additionalHeight + height
    }
}

private extension EachNavigationBar {
    
    func setup(with configuration: Configuration) {
        isHidden = configuration.isHidden
        alpha = configuration.alpha
        isTranslucent = configuration.isTranslucent
        barTintColor = configuration.barTintColor
        tintColor = configuration.tintColor
        
        titleTextAttributes = configuration.titleTextAttributes
        shadowImage = configuration.shadowImage
        setBackgroundImage(
            configuration.backgroundImage,
            for: configuration.barPosition,
            barMetrics: configuration.barMetrics)
        
        barStyle = configuration.barStyle
        statusBarStyle = configuration.statusBarStyle
        
        additionalHeight = configuration.additionalHeight
        
        isShadowHidden = configuration.isShadowHidden
        
        if let shadow = configuration.shadow {
            self.shadow = shadow
        }
        
        if #available(iOS 11.0, *) {
            layoutPaddings = configuration.layoutPaddings
            largeTitleTextAttributes = configuration.largeTitleTextAttributes
        }
    }
}

private extension Bundle {
    
    static var current: Bundle? {
        guard let resourcePath = Bundle(for: EachNavigationBar.self).resourcePath,
            let bundle = Bundle(path: "\(resourcePath)/EachNavigationBar.bundle")
        else {
            return nil
        }
        return bundle
    }
}
