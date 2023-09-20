//
//  NextViewController.swift
//  UIViewController+NavigationBar
//
//  Created by Pircate on 2018/3/26.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
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
        
        navigation.item.title = "Next"
        navigation.bar.tintColor = nil
        
        let titleView = UITextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 100, height: 30))
        titleView.backgroundColor = UIColor.lightGray
        titleView.layer.cornerRadius = 15
        titleView.layer.masksToBounds = true
        navigation.item.titleView = titleView
        navigation.bar.prefersLargeTitles = false
        
        navigation.bar.backBarButtonItem?.shouldBack = { item in
            let alert = UIAlertController(title: "确定退出", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
                item.goBack()
            })
            self.present(alert, animated: true, completion: nil)
            debugPrint("shouldBack")
            return false
        }
    }
    
    @objc private func backBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension NextViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - (scrollView.contentOffset.y) / (scrollView.contentSize.height - view.bounds.height)
        navigation.bar.alpha = alpha
    }
}
