//
//  SubInfoCollectionCell.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import UIKit

class SubInfoCollectionCell: UICollectionViewCell {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let margin = CGFloat(5)
    }
    
    //MARK: - Properties
    
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    private let separateLineView = SeparateLineView(frame: .zero)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - Setup Views

extension SubInfoCollectionCell {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        
        topLabel.do {
            $0.text = "Humidity"
            $0.textColor = .warmGray
            $0.font = .subInfoSmallFont()
        }
        
        bottomLabel.do {
            $0.text = "50%"
            $0.textColor = .warmBlack
            $0.font = .subInfoBigFont()
        }
        
        addSubviews([topLabel, bottomLabel])
    }
}

//MARK: - Layout & Constraints

extension SubInfoCollectionCell {
    
    private func setupConstraints() {
        
        topLabel
            .leadingAnchor(to: leadingAnchor)
            .topAnchor(to: topAnchor, constant: UI.margin)
            .trailingAnchor(to: trailingAnchor)
            .heightAnchor(constant: self.frame.height * 0.3)
            .activateAnchors()
        
        bottomLabel
            .leadingAnchor(to: leadingAnchor)
            .topAnchor(to: topLabel.bottomAnchor)
            .trailingAnchor(to: trailingAnchor)
            .bottomAnchor(to: bottomAnchor)
            .activateAnchors()
    }
}

//MARK: - Configure Cell

extension SubInfoCollectionCell {
    
    func configureCell(topText: String, bottomText: String) {
        self.topLabel.text = topText
        self.bottomLabel.text = bottomText
    }
}