// 
//  MainViewController.swift
//  EachNavigationBar_Example
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/10/29
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var setLargeTitleAlphaSlider: UISlider!
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    private var isStatusBarHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigation.item.title = "EachNavigationBar"
        navigation.item.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonAction))
    }
    
    @objc private func rightBarButtonAction() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }

    @IBAction func isHiddenAction(_ sender: UISwitch) {
        navigation.bar.isHidden = sender.isOn
    }

    @IBAction func setAlphaAction(_ sender: UISlider) {
        navigation.bar.alpha = CGFloat(sender.value)
    }
    
    @IBAction func setTitleAlphaAction(_ sender: UISlider) {
        navigation.bar.setTitleAlpha(CGFloat(sender.value))
    }
    
    @IBAction func isShadowHiddenAction(_ sender: UISwitch) {
        navigation.bar.isShadowHidden = sender.isOn
    }
    
    @IBAction func extraHeightAction(_ sender: UISlider) {
        navigation.bar.extraHeight = CGFloat(sender.value)
    }
    
    @IBAction func prefersLargetTitleAction(_ sender: UISwitch) {
        if #available(iOS 11.0, *) {
            navigation.bar.prefersLargeTitles = sender.isOn
            setLargeTitleAlphaSlider.isEnabled = sender.isOn
        }
    }
    
    @IBAction func setLargeTitleAlphaAction(_ sender: UISlider) {
        if #available(iOS 11.0, *) {
            navigation.bar.setLargeTitleAlpha(CGFloat(sender.value))
        }
    }
    
    @IBAction func changeStatusBarStyle(_ sender: UISwitch) {
        navigation.bar.statusBarStyle = sender.isOn ? .lightContent : .default
    }
    
    @IBAction func isStatusBarHiddenAction(_ sender: UISwitch) {
        isStatusBarHidden = sender.isOn
        setNeedsStatusBarAppearanceUpdate()
    }
}
