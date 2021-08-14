//
//  DailyCollectionCell.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import Then
import UIKit

class DailyCollectionCell: UICollectionViewCell {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let margin = CGFloat(10)
        static let imageSize = CGFloat(30)
    }
    
    //MARK: - Properties
    
    private let dayLabel = UILabel()
    private let weatherIconImageView = UIImageView()
    private let maxTempLabel = UILabel()
    private let minTempLabel = UILabel()
    private var tempStackView: UIStackView!
    
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

extension DailyCollectionCell {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        tempStackView = UIStackView(arrangedSubviews: [maxTempLabel, minTempLabel])
        
        dayLabel.do {
            $0.textColor = .warmBlack
            $0.font = .dailyBoldFont()
        }
        
        weatherIconImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        maxTempLabel.do {
            $0.textColor = .warmBlack
            $0.font = .dailyBoldFont()
        }
        
        minTempLabel.do {
            $0.textColor = .warmGray
            $0.font = .dailyBoldFont()
        }
        
        tempStackView.do {
            $0.axis = .horizontal
            $0.spacing = 15
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        addSubviews([dayLabel, weatherIconImageView, tempStackView])
    }
}

//MARK: - Layout & Constraints

extension DailyCollectionCell {
    
    private func setupConstraints() {
        
        dayLabel
            .leadingAnchor(to: leadingAnchor, constant: UI.margin)
            .centerYAnchor(to: centerYAnchor)
            .activateAnchors()
        
        weatherIconImageView
            .centerXAnchor(to: centerXAnchor)
            .centerYAnchor(to: centerYAnchor)
            .heightAnchor(constant: UI.imageSize)
            .widthAnchor(constant: UI.imageSize)
            .activateAnchors()
            
        tempStackView
            .centerYAnchor(to: centerYAnchor)
            .trailingAnchor(to: trailingAnchor, constant: -UI.margin)
            .activateAnchors()
    }
}

//MARK: - Configure Cell

extension DailyCollectionCell {
    
    func configureCell(viewModel: WeatherDailyViewModel, item: Int) {
        self.dayLabel.text = viewModel.day[item]
        self.weatherIconImageView.image = UIImage(named: viewModel.conditionImage[item])
        self.maxTempLabel.text = viewModel.temp_max[item]
        self.minTempLabel.text = viewModel.temp_min[item]
    }
}


