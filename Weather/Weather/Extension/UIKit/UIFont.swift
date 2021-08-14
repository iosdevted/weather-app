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
    
    static func mainDescriptionFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 20)
    }
    
    static func mainCityNameBoldFont() -> UIFont? {
        return UIFont.boldSystemFont(ofSize: 30)
    }
    
    static func mainTemperatureBoldFont() -> UIFont? {
        return UIFont.boldSystemFont(ofSize: 70)
    }
    
    static func hourlyFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 13)
    }
    
    static func dailyFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 17)
    }
    
    static func dailyBoldFont() -> UIFont? {
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    static func summaryBoldFont() -> UIFont? {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static func subInfoSmallFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 12)
    }
    
    static func subInfoBigFont() -> UIFont? {
        return UIFont.systemFont(ofSize: 20)
    }
}

