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
        static let basicMargin = CGFloat(10)
    }
    
    //MARK: - Properties
    
    private lazy var cityNameLabel = UILabel().then {
        $0.font = .mainCityNameBoldFont()
        $0.textColor = .warmBlack
        $0.textAlignment = .center
    }
    private lazy var temperatureLabel = UILabel().then {
        $0.font = .mainTemperatureBoldFont()
        $0.textColor = .warmBlack
        $0.textAlignment = .center
    }
    private lazy var weatherDescriptionLabel = UILabel().then {
        $0.font = .mainDescriptionFont()
        $0.textColor = .warmBlack
        $0.textAlignment = .center
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

extension HeaderView {
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([cityNameLabel, temperatureLabel, weatherDescriptionLabel])
        setupConstraints()
    }
    
    private func setupConstraints() {
    
        cityNameLabel
            .bottomAnchor(to: weatherDescriptionLabel.topAnchor, constant: -UI.basicMargin)
            .centerXAnchor(to: centerXAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .heightAnchor(constant: 40)
            .activateAnchors()
        
        weatherDescriptionLabel
            .centerYAnchor(to: centerYAnchor)
            .centerXAnchor(to: centerXAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .heightAnchor(constant: 30)
            .activateAnchors()
        
        temperatureLabel
            .topAnchor(to: weatherDescriptionLabel.bottomAnchor, constant: UI.basicMargin)
            .centerXAnchor(to: centerXAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .heightAnchor(constant: 60)
            .activateAnchors()
    }
}

//MARK: - Configure View

extension HeaderView {
    func configureView(viewModel: [WeatherViewModel], cityName: String) {
        guard let recentData = viewModel.first else { return }
        cityNameLabel.text = cityName
        temperatureLabel.text = recentData.tempOriginal
        weatherDescriptionLabel.text = recentData.description
    }
}
