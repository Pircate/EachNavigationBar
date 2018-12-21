// 
//  Duplicatable.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/21
//  Copyright © 2018年 Pircate. All rights reserved.
//

protocol Duplicatable {
    func duplicate() -> Self?
}

extension Duplicatable where Self: NSObject {
    func duplicate() -> Self? {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
    }
}

extension NSObject: Duplicatable {}
