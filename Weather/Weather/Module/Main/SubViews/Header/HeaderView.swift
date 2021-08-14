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
        
        static let margin = CGFloat(10)
        static let viewWidth = CGFloat(200)
    }
    
    //MARK: - Properties
    
    private let cityNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    
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

extension HeaderView {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        cityNameLabel.do {
            $0.font = .mainCityNameBoldFont()
            $0.textColor = .warmBlack
            $0.textAlignment = .center
        }
        
        temperatureLabel.do {
            $0.font = .mainTemperatureBoldFont()
            $0.textColor = .warmBlack
            $0.textAlignment = .center
        }
        
        weatherDescriptionLabel.do {
            $0.font = .mainDescriptionFont()
            $0.textColor = .warmBlack
            $0.textAlignment = .center
        }
        
        addSubviews([cityNameLabel, temperatureLabel, weatherDescriptionLabel])
    }
}

//MARK: - Layout & Constraints

extension HeaderView {
    
    private func setupConstraints() {
        
        cityNameLabel
            .bottomAnchor(to: weatherDescriptionLabel.topAnchor, constant: -UI.margin)
            .centerXAnchor(to: centerXAnchor)
            .widthAnchor(constant: UI.viewWidth)
            .heightAnchor(constant: 40)
            .activateAnchors()
        
        weatherDescriptionLabel
            .centerYAnchor(to: centerYAnchor)
            .centerXAnchor(to: centerXAnchor)
            .widthAnchor(constant: UI.viewWidth / 2)
            .heightAnchor(constant: 30)
            .activateAnchors()
        
        temperatureLabel
            .topAnchor(to: weatherDescriptionLabel.bottomAnchor, constant: UI.margin)
            .centerXAnchor(to: centerXAnchor)
            .widthAnchor(constant: UI.viewWidth)
            .heightAnchor(constant: 60)
            .activateAnchors()
    }
}

//MARK: - Configure View

extension HeaderView {
    func configureView(viewModel: [WeatherViewModel]) {
        guard let recentData = viewModel.first else { return }
        cityNameLabel.text = recentData.cityName
        temperatureLabel.text = recentData.tempOriginal
        weatherDescriptionLabel.text = recentData.description
    }
}
