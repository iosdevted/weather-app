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
        static let basicMargin = CGFloat(10)
        static let imageSize = CGFloat(30)
    }
    
    //MARK: - Properties
    
    private lazy var dayLabel = UILabel().then {
        $0.textColor = .warmBlack
        $0.font = .dailyBoldFont()
    }
    private lazy var weatherIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private lazy var maxTempLabel = UILabel().then {
        $0.textColor = .warmBlack
        $0.font = .dailyBoldFont()
    }
    private lazy var minTempLabel = UILabel().then {
        $0.textColor = .warmGray
        $0.font = .dailyBoldFont()
    }
    private var stackView = UIStackView()
    
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
        stackView = UIStackView(arrangedSubviews: [maxTempLabel, minTempLabel])
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 15
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        addSubviews([dayLabel, weatherIconImageView, stackView])
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        dayLabel
            .leadingAnchor(to: leadingAnchor, constant: UI.basicMargin)
            .centerYAnchor(to: centerYAnchor)
            .activateAnchors()
        
        weatherIconImageView
            .centerXAnchor(to: centerXAnchor)
            .centerYAnchor(to: centerYAnchor)
            .heightAnchor(constant: UI.imageSize)
            .widthAnchor(constant: UI.imageSize)
            .activateAnchors()
            
        stackView
            .centerYAnchor(to: centerYAnchor)
            .trailingAnchor(to: trailingAnchor, constant: -UI.basicMargin)
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


