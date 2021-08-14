//
//  MainTitleView.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Then
import UIKit

class HeaderLocationTitleView: UIView {
    
//    private struct UI {
//
//        struct ArrowImageView {
//            static let trailing = CGFloat(4)
//            static let width = CGFloat(20)
//            static let height = CGFloat(20)
//        }
//    }
    
    //MARK: - Properties
    
//    let arrowImageView = UIImageView()
    let cityNameLabel = UILabel()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup Views

extension HeaderLocationTitleView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
//        arrowImageView.do {
//            $0.tintColor = .warmBlack
//        }
        
        cityNameLabel.do {
            $0.font = .mainCityNameBoldFont()
            $0.textColor = .warmBlack
        }
        
        addSubviews([cityNameLabel])
    }
}

//MARK: - Layout & Constraints

extension HeaderLocationTitleView {

    private func setupConstraints() {
        cityNameLabel
            .centerXAnchor(to: centerXAnchor)
            .centerYAnchor(to: centerYAnchor)
            .activateAnchors()
        
//        arrowImageView
//            .trailingAnchor(to: cityNameLabel.leadingAnchor, constant: -UI.ArrowImageView.trailing)
//            .centerYAnchor(to: centerYAnchor)
//            .widthAnchor(constant: UI.ArrowImageView.width)
//            .heightAnchor(constant: UI.ArrowImageView.height)
//            .activateAnchors()
    }
}
