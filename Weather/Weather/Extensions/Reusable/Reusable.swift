//
//  Reusable.swift
//  Weather
//
//  Created by Ted on 2021/08/17.
//

import Foundation

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    //Make indentifier to its own class name
    //class SomeCell: UITableViewCell -> SomceCell
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
