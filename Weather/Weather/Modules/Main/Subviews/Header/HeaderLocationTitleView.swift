//
//  MainTitleView.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Then
import UIKit

class HeaderLocationTitleView: UIView {
    
    //MARK: - Properties
    
    private let arrowImageView = UIImageView()
    private let cityNameLabel = UILabel()
    
    var title: String? {
        didSet {
            cityNameLabel.text = title
        }
    }
    
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
        
        arrowImageView.do {
            $0.image = UIImage(systemName: "location.fill")
        }
        
        cityNameLabel.do {
            $0.text = "Seoul"
            $0.font = .mainFont(size: 20)
            $0.textColor = .warmBlack
        }
        
        addSubviews([arrowImageView, cityNameLabel])
    }
}

//MARK: - Layout & Constraints

extension HeaderLocationTitleView {
    
    //UI Metrics
    
    private struct UI {
        
        struct ArrowImageView {
            static let trailing = CGFloat(4)
            static let width = CGFloat(12)
            static let height = CGFloat(12)
        }
    }
    
    //Setup Constraints
    
    private func setupConstraints() {
        cityNameLabel
            .centerXAnchor(to: centerXAnchor)
            .centerYAnchor(to: centerYAnchor)
            .activateAnchors()
        
        arrowImageView
            .trailingAnchor(to: cityNameLabel.leadingAnchor, constant: -UI.ArrowImageView.trailing)
            .centerYAnchor(to: centerYAnchor)
            .widthAnchor(constant: UI.ArrowImageView.width)
            .heightAnchor(constant: UI.ArrowImageView.height)
            .activateAnchors()
    }
}
