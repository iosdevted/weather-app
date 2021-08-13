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
        static let margin = CGFloat(5)
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
            $0.font = .dailyFont()
        }
        
        weatherIconImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.layer.masksToBounds = true
        }
        
        maxTempLabel.do {
            $0.textColor = .warmBlack
            $0.font = .dailyFont()
        }
        
        minTempLabel.do {
            $0.textColor = .lightGray
            $0.font = .dailyFont()
        }
        
        tempStackView.do {
            $0.axis = .horizontal
            $0.spacing = 25
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
    
    func configureCell(day: String, image: String, maxTemp: String, minTemp: String) {
        self.dayLabel.text = day
        self.weatherIconImageView.image = UIImage(named: image)
        self.maxTempLabel.text = maxTemp
        self.minTempLabel.text = minTemp
    }
}


