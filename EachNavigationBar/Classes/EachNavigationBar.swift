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
            viewController?.adjustsSafeAreaInsets()
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
    
    private var appearance: UINavigationBarAppearance {
        if let _appearance = _appearance as? UINavigationBarAppearance {
            return _appearance
        }
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = self.barTintColor
        appearance.titleTextAttributes = self.titleTextAttributes ?? [:]
        appearance.largeTitleTextAttributes = self.largeTitleTextAttributes ?? [:]
        
        _appearance = appearance
        
        return appearance
    }
    
    private var _appearance: Any?
    
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
            viewController?.adjustsSafeAreaInsets()
        }
    }
    
    open override var isTranslucent: Bool {
        willSet {
            changed.insert(\.isTranslucent)
        }
        didSet {
            guard !isTranslucent else { return }
            
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
            appearance.shadowImage = shadowImage
            updateAppearance(appearance)
        }
    }
    
    open override var titleTextAttributes: [NSAttributedString.Key: Any]? {
        willSet {
            changed.insert(\.titleTextAttributes)
        }
        didSet {
            appearance.titleTextAttributes = titleTextAttributes ?? [:]
            updateAppearance(appearance)
        }
    }
    
    open override var prefersLargeTitles: Bool {
        get { return super.prefersLargeTitles }
        set {
            super.prefersLargeTitles = newValue
            
            superNavigationBar?.prefersLargeTitles = newValue
            
            changed.insert(\.prefersLargeTitles)
            
            updateAppearance(appearance)
        }
    }
    
    open override var largeTitleTextAttributes: [NSAttributedString.Key: Any]? {
        get { return super.largeTitleTextAttributes }
        set {
            super.largeTitleTextAttributes = newValue
            
            viewController?.navigationItem.title = viewController?._navigationItem.title
            superNavigationBar?.largeTitleTextAttributes = newValue
            
            changed.insert(\.largeTitleTextAttributes)
            
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
        
        appearance.backgroundImage = backgroundImage
        updateAppearance(appearance)
    }
}

extension EachNavigationBar {
    
    var superBarStyle: UIBarStyle {
        return statusBarStyle == .lightContent ? .black : .default
    }
    
    var _additionalHeight: CGFloat {
        guard !isLargeTitleShown else {
            return 0
        }
        
        return additionalHeight
    }
    
    var barMinY: CGFloat {
        let window = window ?? UIApplication.shared.windows.first { $0.isKeyWindow }
        
        return window?.safeAreaInsets.top ?? 0
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
    
    var contentView: UIView? {
        if let contentView = _contentView { return contentView }
        
        _contentView = subviews.first {
            String(describing: $0.classForCoder) == "_UINavigationBarContentView"
        }
        
        return _contentView
    }
    
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
        
        adjustsLayoutMargins()
    }
    
    func adjustsLayoutMargins() {
        layoutMargins = .barLayoutMargins
        
        guard let contentView = contentView else { return }
        
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
    
    func updateAppearance(_ appearance: UINavigationBarAppearance) {
        self.standardAppearance = appearance
        self.compactAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
