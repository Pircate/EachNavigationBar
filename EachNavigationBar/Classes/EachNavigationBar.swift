//
//  EachNavigationBar.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/3/28.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

open class EachNavigationBar: UINavigationBar {
    /// 记录修改过的属性
    var changed: Set<PartialKeyPath<EachNavigationBar>> = []
    
    /// automatically adjusts position when view layout
    open var automaticallyAdjustsPosition: Bool = true
    
    open override var barStyle: UIBarStyle {
        willSet {
            changed.insert(\.barStyle)
        }
    }
    
    /// Additional height for the navigation bar.
    open var additionalHeight: CGFloat = 0 {
        willSet {
            changed.insert(\.additionalHeight)
        }
        didSet {
            frame.size.height = barHeight + _additionalHeight
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    /// Hides shadow image
    open var isShadowHidden: Bool = false {
        willSet {
            changed.insert(\.isShadowHidden)
        }
        didSet {
            guard let background = subviews.first else { return }
            background.clipsToBounds = isShadowHidden
        }
    }
    
    open var statusBarStyle: UIStatusBarStyle = .default {
        willSet {
            changed.insert(\.statusBarStyle)
        }
        didSet {
            superNavigationBar?.barStyle = superBarStyle
        }
    }
    
    /// Bar button item to use for the back button in the child navigation item.
    open var backBarButtonItem: BackBarButtonItem? {
        willSet {
            changed.insert(\.backBarButtonItem)
        }
        didSet {
            backBarButtonItem?.navigationController = viewController?.navigationController
            
            viewController?._navigationItem.leftBarButtonItem = backBarButtonItem
        }
    }
    
    @available(iOS 11.0, *)
    /// Padding of navigation bar content view.
    open var layoutPaddings: UIEdgeInsets {
        get { _layoutPaddings }
        set {
            _layoutPaddings = newValue
            changed.insert(\.layoutPaddings)
        }
    }
    
    /// Additional view at the bottom of the navigation bar
    open var additionalView: UIView? {
        didSet {
            guard let additionalView = additionalView else {
                oldValue?.removeFromSuperview()
                return
            }
            
            setupAdditionalView(additionalView)
        }
    }
    
    open var shadow: Shadow = .none {
        willSet { changed.insert(\.shadow) }
        didSet { layer.apply(shadow) }
    }
    
    @available(iOS 13.0, *)
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = self.barTintColor
        appearance.titleTextAttributes = self.titleTextAttributes ?? [:]
        appearance.largeTitleTextAttributes = self.largeTitleTextAttributes ?? [:]
        
        return appearance
    }()
    
    private var _alpha: CGFloat = 1
    
    private var _layoutPaddings: UIEdgeInsets = .barLayoutPaddings
    
    private var _contentView: UIView?
    
    private weak var viewController: UIViewController?
    
    public convenience init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
        setItems([viewController._navigationItem], animated: false)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        _layoutSubviews()
    }
}

// MARK: - override
extension EachNavigationBar {
    
    open override var isHidden: Bool {
        willSet {
            changed.insert(\.isHidden)
        }
        didSet {
            viewController?.adjustsSafeAreaInsetsAfterIOS11()
        }
    }
    
    open override var isTranslucent: Bool {
        willSet {
            changed.insert(\.isTranslucent)
        }
        didSet {
            guard #available(iOS 13.0, *), !isTranslucent else { return }
            
            appearance.backgroundEffect = nil
            updateAppearance(appearance)
        }
    }
    
    open override var alpha: CGFloat {
        get { return super.alpha }
        set {
            _alpha = newValue
            
            layer.shadowOpacity = newValue < 1 ? 0 : shadow.opacity
            
            if let background = subviews.first {
                background.alpha = newValue
            }
            
            changed.insert(\.alpha)
        }
    }
    
    open override var tintColor: UIColor! {
        willSet {
            changed.insert(\.tintColor)
        }
    }
    
    open override var barTintColor: UIColor? {
        willSet {
            changed.insert(\.barTintColor)
        }
        didSet {
            guard #available(iOS 13.0, *) else { return }
            
            appearance.backgroundColor = barTintColor
            updateAppearance(appearance)
        }
    }
    
    /// map to barTintColor
    open override var backgroundColor: UIColor? {
        get { return super.backgroundColor }
        set { barTintColor = newValue }
    }
    
    open override var shadowImage: UIImage? {
        willSet {
            changed.insert(\.shadowImage)
        }
        didSet {
            guard #available(iOS 13.0, *) else { return }
            
            appearance.shadowImage = shadowImage
            updateAppearance(appearance)
        }
    }
    
    open override var titleTextAttributes: [NSAttributedString.Key : Any]? {
        willSet {
            changed.insert(\.titleTextAttributes)
        }
        didSet {
            guard #available(iOS 13.0, *) else { return }
            
            appearance.titleTextAttributes = titleTextAttributes ?? [:]
            updateAppearance(appearance)
        }
    }
    
    @available(iOS 11.0, *)
    open override var prefersLargeTitles: Bool {
        get { return super.prefersLargeTitles }
        set {
            super.prefersLargeTitles = newValue
            
            superNavigationBar?.prefersLargeTitles = newValue
            
            changed.insert(\.prefersLargeTitles)
            
            guard #available(iOS 13.0, *) else { return }
            
            updateAppearance(appearance)
        }
    }
    
    @available(iOS 11.0, *)
    open override var largeTitleTextAttributes: [NSAttributedString.Key : Any]? {
        get { return super.largeTitleTextAttributes }
        set {
            super.largeTitleTextAttributes = newValue
            
            viewController?.navigationItem.title = viewController?._navigationItem.title
            superNavigationBar?.largeTitleTextAttributes = newValue
            
            changed.insert(\.largeTitleTextAttributes)
            
            guard #available(iOS 13.0, *) else { return }
            
            appearance.largeTitleTextAttributes = newValue ?? [:]
            updateAppearance(appearance)
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if super.point(inside: point, with: event) { return true }
        
        return additionalView?.frame.contains(point) ?? false
    }
    
    open override func setBackgroundImage(
        _ backgroundImage: UIImage?,
        for barPosition: UIBarPosition,
        barMetrics: UIBarMetrics
    ) {
        super.setBackgroundImage(backgroundImage, for: barPosition, barMetrics: barMetrics)
        
        guard #available(iOS 13.0, *) else { return }
        
        appearance.backgroundImage = backgroundImage
        updateAppearance(appearance)
    }
}

extension EachNavigationBar {
    
    var superBarStyle: UIBarStyle {
        return statusBarStyle == .lightContent ? .black : .default
    }
    
    var _additionalHeight: CGFloat {
        if #available(iOS 11.0, *) {
            if isLargeTitleShown { return 0 }
        }
        return additionalHeight
    }
    
    var barMinY: CGFloat {
        if let superNavigationBar = superNavigationBar {
            return superNavigationBar.frame.minY
        }
         
        if #available(iOS 13.0, *) {
            return window?.windowScene?.statusBarManager?.statusBarFrame.maxY ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.maxY
        }
    }
    
    func adjustsLayout() {
        guard let navigationBar = superNavigationBar else { return }
        
        if automaticallyAdjustsPosition {
            frame = navigationBar.frame
            frame.origin.y = barMinY
        } else {
            frame.size = navigationBar.frame.size
        }
        
        frame.size.height = navigationBar.frame.height + _additionalHeight
    }
}

// MARK: - private
private extension EachNavigationBar {
    
    var superNavigationBar: UINavigationBar? {
        return viewController?.navigationController?.navigationBar
    }
    
    @available(iOS 11.0, *)
    var contentView: UIView? {
        if let contentView = _contentView { return contentView }
        
        _contentView = subviews.first {
            String(describing: $0.classForCoder) == "_UINavigationBarContentView"
        }
        
        return _contentView
    }
    
    @available(iOS 11.0, *)
    var isLargeTitleShown: Bool {
        return prefersLargeTitles && viewController?._navigationItem.largeTitleDisplayMode != .never
    }
    
    var barHeight: CGFloat {
        superNavigationBar?.frame.height ?? .navigationBarHeight
    }
    
    func _layoutSubviews() {
        guard let background = subviews.first else { return }
        background.alpha = _alpha
        background.clipsToBounds = isShadowHidden
        background.frame = CGRect(
            x: 0,
            y: -barMinY,
            width: bounds.width,
            height: bounds.height + barMinY
        )
        
        adjustsLayoutMarginsAfterIOS11()
    }
    
    func adjustsLayoutMarginsAfterIOS11() {
        guard #available(iOS 11.0, *) else { return }
        
        layoutMargins = .barLayoutMargins
        
        guard let contentView = contentView else { return }
        
        if #available(iOS 13.0, *) {
            contentView.frame = CGRect(
                x: layoutPaddings.left - layoutMargins.left,
                y: isLargeTitleShown ? 0 : additionalHeight,
                width: layoutMargins.left
                    + layoutMargins.right
                    - layoutPaddings.left
                    - layoutPaddings.right
                    + contentView.frame.width,
                height: contentView.frame.height
            )
        } else {
            contentView.frame.origin.y = isLargeTitleShown ? 0 : additionalHeight
            contentView.layoutMargins = layoutPaddings
        }
    }
    
    func setupAdditionalView(_ additionalView: UIView) {
        addSubview(additionalView)
        additionalView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            additionalView.topAnchor.constraint(equalTo: bottomAnchor),
            additionalView.leftAnchor.constraint(equalTo: leftAnchor),
            additionalView.widthAnchor.constraint(equalTo: widthAnchor),
            additionalView.heightAnchor.constraint(equalToConstant: additionalView.frame.height)
        ])
    }
    
    @available(iOS 13.0, *)
    func updateAppearance(_ appearance: UINavigationBarAppearance) {
        self.standardAppearance = appearance
        self.compactAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
