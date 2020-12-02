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
        
        navigation.item.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(rightBarButtonAction))
        navigation.item.title = "Home"
        navigation.bar.titleTextAttributes = [
            .foregroundColor: UIColor.blue,
            .font: UIFont.systemFont(ofSize: 24)
        ]
        
        navigation.bar.backBarButtonItem?.willBack = {
            debugPrint("willBack")
        }
        navigation.bar.backBarButtonItem?.didBack = {
            debugPrint("didBack")
        }
        
        // if you want change navigation bar position
        navigation.bar.automaticallyAdjustsPosition = false
        
        if #available(iOS 11.0, *) {
            navigation.bar.largeTitleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 80),
                .foregroundColor: UIColor.orange
            ]
            navigation.bar.prefersLargeTitles = true
            navigation.item.largeTitleDisplayMode = .always
        }
    }
    
    @objc private func rightBarButtonAction() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let statusBarMaxY = navigationController!.navigationBar.frame.minY
        let originY = -scrollView.contentOffset.y + statusBarMaxY
        let alpha = 1 - (scrollView.contentOffset.y) / navigation.bar.frame.height
        navigation.bar.setTintAlpha(alpha)
        navigation.bar.setTitleAlpha(alpha)
        if #available(iOS 11.0, *) {
            navigation.bar.setLargeTitleAlpha(alpha)
        }
        if originY <= statusBarMaxY {
            let minY = statusBarMaxY - navigation.bar.frame.height
            navigation.bar.frame.origin.y = originY > minY ? originY : minY
        } else {
            if #available(iOS 11.0, *) { navigation.bar.setLargeTitleAlpha(1) }
            navigation.bar.setTitleAlpha(1)
            navigation.bar.setTintAlpha(1)
            navigation.bar.frame.origin.y = statusBarMaxY
        }
    }
}
