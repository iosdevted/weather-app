//
//  UIView+Subviews.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
