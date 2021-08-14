//
//  MainWeatherView.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import Then
import UIKit

class HeaderView: UIView {
    
    //MARK: - UI Metrics
    
    private struct UI {
        
        struct WeatherImageView {
            static let top = CGFloat(80)
            static let width = CGFloat(100)
            static let height = CGFloat(100)
        }
        
        struct LocationTitleView {
            static let top = CGFloat(20)
            static let width = CGFloat(300)
            static let height = CGFloat(20)
        }
        
        struct TemperatureLabel {
            static let top = CGFloat(10)
            static let height = CGFloat(46)
        }
        
        struct DescriptionLabel {
            static let top = CGFloat(5)
            static let height = CGFloat(23)
        }
    }
    
    //MARK: - Properties
    
    private let weatherImageView = UIImageView()
    private let weatherLocationTitleView = HeaderLocationTitleView()
    private let temperatureLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func setNeedsLayout() {
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup Views

extension HeaderView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        
        //FIXME: change font and color
        
        temperatureLabel.do {
            $0.font = .mainFont(size: 35)
            $0.textColor = .warmBlack
            $0.textAlignment = .center
        }
        
        weatherDescriptionLabel.do {
            $0.font = .mainFont(size: 20)
            $0.textColor = .warmBlack
            $0.textAlignment = .center
            
        }
        
        addSubviews([weatherImageView, weatherLocationTitleView, temperatureLabel, weatherDescriptionLabel])
    }
}

//MARK: - Layout & Constraints

extension HeaderView {
    
    private func setupConstraints() {
        weatherImageView
            .topAnchor(to: topAnchor, constant: frame.height * 0.15)
            .centerXAnchor(to: centerXAnchor)
            .widthAnchor(constant: frame.width * 0.5)
            .bottomAnchor(to: bottomAnchor, constant: -frame.height * 0.4)
            .activateAnchors()
        
        weatherLocationTitleView
            .topAnchor(to: weatherImageView.bottomAnchor)
            .heightAnchor(constant: frame.height * 0.1)
            .centerXAnchor(to: centerXAnchor)
            .activateAnchors()
        
        temperatureLabel
            .topAnchor(to: weatherLocationTitleView.bottomAnchor)
            .heightAnchor(constant: frame.height * 0.15)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .activateAnchors()
        
        weatherDescriptionLabel
            .topAnchor(to: temperatureLabel.bottomAnchor)
            .heightAnchor(constant: frame.height * 0.1)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .activateAnchors()
    }
}

//MARK: - Configure View

extension HeaderView {
    func configureView(viewModel: [WeatherViewModel]) {
        guard let recentData = viewModel.first else { return }
        weatherLocationTitleView.arrowImageView.image = UIImage(systemName: "location.fill")
        weatherImageView.image = UIImage(named: recentData.conditionImage)
        weatherLocationTitleView.title = recentData.cityName
        temperatureLabel.text = recentData.temp
        weatherDescriptionLabel.text = recentData.description
    }
}
