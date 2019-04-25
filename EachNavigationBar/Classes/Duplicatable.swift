// 
//  Duplicatable.swift
//  EachNavigationBar
//
//  Created by Pircate(gao497868860@gmail.com) on 2018/12/21
//  Copyright © 2018年 Pircate. All rights reserved.
//

protocol Duplicatable: NSSecureCoding {
    func duplicate() throws -> Self?
}

extension Duplicatable where Self: NSObject {
    func duplicate() throws -> Self? {
        if #available(iOS 11.0, *) {
            let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: Self.self, from: data)
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: self)
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? Self
        }
    }
}

extension UINavigationItem: Duplicatable {
    public static var supportsSecureCoding: Bool {
        return true
    }
}
