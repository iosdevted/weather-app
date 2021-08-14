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
        static let bottomMarginRatio = CGFloat(0.1)
        static let margin = CGFloat(10)
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
            $0.font = .hourlyFont()
            $0.textColor = .warmBlack
        }
        
        weatherIconImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        tempLabel.do {
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
            .bottomAnchor(to: bottomAnchor, constant: -bounds.height * UI.bottomMarginRatio)
            .activateAnchors()
        
        weatherIconImageView
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .heightAnchor(constant: bounds.height * UI.iconImageHeightRatio)
            .topAnchor(to: hourLabel.bottomAnchor, constant: UI.margin)
            .bottomAnchor(to: tempLabel.topAnchor, constant: -UI.margin)
            .activateAnchors()
    }
}

//MARK: - Configure Cell

extension HourlyCollectionCell {
    
    func configureCell(viewModel: [WeatherViewModel], item: Int) {
        hourLabel.text = viewModel[item].hour
        weatherIconImageView.image = UIImage(named: viewModel[item].conditionImage)
        tempLabel.text = viewModel[item].temp
    }
}
