//
//  ViewController.swift
//  EachNavigationBar
//
//  Created by Pircate on 04/19/2018.
//  Copyright (c) 2018 Pircate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        scrollView.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        return scrollView
    }()
    
    private lazy var tipLabel: UILabel = {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        lable.center = view.center
        lable.textAlignment = .center
        lable.text = "上下滑动试试"
        return lable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        view.addSubview(tipLabel)
        
        navigation.item.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonAction))
        navigation.item.title = "Home"
        navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        // remove blur effect
        navigation.bar.isTranslucent = false
        
        // hide bottom black line
        navigation.bar.setShadowHidden(true)
        
        // if you need to set status bar style lightContent
        // navigationController?.navigationBar.barStyle = .black
        
        // if you want change navigation bar position
        navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = true
        
        if #available(iOS 11.0, *) {
            navigationController?.navigation.configuration.prefersLargeTitles = true
            navigation.bar.isLargeTitleHidden = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func rightBarButtonAction() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let statusBarMaxY = UIApplication.shared.statusBarFrame.maxY
        let originY = -scrollView.contentOffset.y + statusBarMaxY
        let alpha = 1 - (scrollView.contentOffset.y) / navigation.bar.frame.height
        navigation.bar.tintColor = navigation.bar.tintColor.withAlphaComponent(alpha)
        navigation.bar.titleTextAttributes = [.foregroundColor: UIColor.blue.withAlphaComponent(alpha)]
        if originY <= statusBarMaxY {
            let minY = statusBarMaxY - navigation.bar.frame.height
            navigation.bar.frame.origin.y = originY > minY ? originY : minY
        }
        else {
            navigation.bar.frame.origin.y = statusBarMaxY
        }
    }
}
