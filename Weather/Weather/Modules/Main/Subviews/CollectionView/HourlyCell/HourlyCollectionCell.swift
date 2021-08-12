//
//  HourlyCollectionCell.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Then
import UIKit

class HourlyCollectionCell: UICollectionViewCell {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let labelHeightRatio = CGFloat(0.15)
        static let iconImageHeightRatio = CGFloat(0.6)
        static let margin = CGFloat(0.1)
    }
    
    //MARK: - Properties
    
    private var hourLabel = UILabel()
    private var weatherIconImageView = UIImageView()
    private var tempLabel = UILabel()
    
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

extension HourlyCollectionCell {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        hourLabel.do {
            $0.text = "19"
            $0.font = .hourlyFont()
            $0.textColor = .warmBlack
        }
        
        weatherIconImageView.do {
            $0.image = UIImage(named: "shade")
            $0.contentMode = .scaleAspectFit
        }
        
        tempLabel.do {
            $0.text = "31°"
            $0.font = .hourlyFont()
            $0.textColor = .warmBlack
        }
        
        addSubviews([hourLabel, weatherIconImageView, tempLabel])
    }
}

//MARK: - Layout & Constraints

extension HourlyCollectionCell {
    
    private func setupConstraints() {
        
        hourLabel
            .centerXAnchor(to: centerXAnchor)
            .heightAnchor(constant: bounds.height * UI.labelHeightRatio)
            .topAnchor(to: topAnchor)
            .activateAnchors()
        
        tempLabel
            .centerXAnchor(to: centerXAnchor)
            .heightAnchor(constant: bounds.height * UI.labelHeightRatio)
            .bottomAnchor(to: bottomAnchor, constant: -bounds.height * UI.margin)
            .activateAnchors()
        
        weatherIconImageView
            .centerXAnchor(to: centerXAnchor)
            .heightAnchor(constant: bounds.height * UI.iconImageHeightRatio)
            .topAnchor(to: hourLabel.bottomAnchor)
            .bottomAnchor(to: tempLabel.topAnchor)
            .activateAnchors()
    }
}

//MARK: - Configure Cell

extension HourlyCollectionCell {
    
    func configureCell(hour: String, icon: String, temp: String) {
        hourLabel.text = hour
        weatherIconImageView.image = UIImage(named: icon)
        tempLabel.text = temp
    }
}
