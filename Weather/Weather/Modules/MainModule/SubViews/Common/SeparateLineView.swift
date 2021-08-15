//
//  SeparateLineView.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class SeparateLineView: UIView {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .warmBlack
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Layout & Constraints
    
    func setupConstraints(bottom: NSLayoutYAxisAnchor) {
        
        self.heightAnchor(constant: 0.5)
            .bottomAnchor(to: bottom)
            .activateAnchors()
    }
}
