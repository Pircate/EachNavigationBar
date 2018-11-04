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
        adjustsScrollViewContentInset(scrollView)
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
        
        navigation.bar.statusBarStyle = .lightContent
        navigation.bar.setBackgroundImage(#imageLiteral(resourceName: "nav"), for: .default)
        
        navigation.item.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonAction))
        navigation.item.rightBarButtonItem?.tintColor = UIColor.orange
        navigation.item.title = "Home"
        navigation.bar.titleTextAttributes = [
            .foregroundColor: UIColor.blue,
            .font: UIFont.systemFont(ofSize: 24)]
        
        let backButton = UIButton(type: .custom)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.red, for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(backBarButtonAction), for: .touchUpInside)
        navigation.item.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // if you want change navigation bar position
        navigation.bar.isUnrestoredWhenViewWillLayoutSubviews = true
        
        if #available(iOS 11.0, *) {
            navigation.bar.largeTitleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 50),
                .foregroundColor: UIColor.green]
            navigation.bar.prefersLargeTitles = true
        }
    }
    
    @objc private func backBarButtonAction() {
        navigationController?.popViewController(animated: true)
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
        navigation.item.leftBarButtonItem?.customView?.alpha = alpha
        navigation.bar.setTintAlpha(alpha)
        navigation.bar.setTitleAlpha(alpha)
        if #available(iOS 11.0, *) {
            navigation.bar.setLargeTitleAlpha(alpha)
        }
        if originY <= statusBarMaxY {
            let minY = statusBarMaxY - navigation.bar.frame.height
            navigation.bar.frame.origin.y = originY > minY ? originY : minY
        }
        else {
            navigation.bar.frame.origin.y = statusBarMaxY
        }
    }
}
