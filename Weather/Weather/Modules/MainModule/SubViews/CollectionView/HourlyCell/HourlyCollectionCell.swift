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
        static let labelHeight = CGFloat(15)
        static let miniMargin = CGFloat(5)
        static let basicMargin = CGFloat(10)
    }
    
    //MARK: - Properties
    
    private lazy var hourLabel = UILabel().then {
        $0.font = .hourlyBoldFont
        $0.textColor = .warmBlack
    }
    private lazy var weatherIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private lazy var tempLabel = UILabel().then {
        $0.font = .hourlyBoldFont
        $0.textColor = .warmBlack
    }
    
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
        backgroundColor = .clear
        addSubviews([hourLabel, weatherIconImageView, tempLabel])
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        hourLabel
            .centerXAnchor(to: centerXAnchor)
            .heightAnchor(constant: UI.labelHeight)
            .topAnchor(to: topAnchor)
            .activateAnchors()
        
        tempLabel
            .centerXAnchor(to: centerXAnchor)
            .heightAnchor(constant: UI.labelHeight)
            .bottomAnchor(to: bottomAnchor, constant: -UI.miniMargin)
            .activateAnchors()
        
        weatherIconImageView
            .leadingAnchor(to: leadingAnchor, constant: UI.basicMargin)
            .trailingAnchor(to: trailingAnchor, constant: -UI.basicMargin)
            .topAnchor(to: hourLabel.bottomAnchor, constant: UI.basicMargin)
            .bottomAnchor(to: tempLabel.topAnchor, constant: -UI.basicMargin)
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
