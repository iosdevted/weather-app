//
//  UIFont.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit.UIFont

extension UIFont {
    
    static var mainDescriptionFont: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    static var mainCityNameBoldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 30)
    }
    
    static var mainTemperatureBoldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 70)
    }
    
    static var hourlyBoldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 13)
    }
    
    static var dailyFont: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    static var dailyBoldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    static var summaryBoldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static var subInfoFont: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    static var subInfoBoldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 23)
    }
    
    static var searchFont: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
}

