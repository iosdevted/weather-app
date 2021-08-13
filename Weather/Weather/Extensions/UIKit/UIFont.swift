//
//  UIFont.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit.UIFont

extension UIFont {
    
    static func mainFont(size: CGFloat) -> UIFont? {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func hourlyFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 13)
    }
    
    static func dailyFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 16)
    }
}

