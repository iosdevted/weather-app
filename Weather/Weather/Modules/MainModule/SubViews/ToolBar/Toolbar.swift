//
//  Toolbar.swift
//  Weather
//
//  Created by Ted on 2021/08/14.
//

import Then
import UIKit

class ToolBar: UIToolbar {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let basicMargin = CGFloat(15)
    }
    
    // MARK: - Callback
    
    var weatherButtonDidTap: (() -> ())?
    var settingButtonDidTap: (() -> ())?
    
    //MARK: - Properties
    
    private let configuration = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .default)
    private lazy var weatherButton = UIButton().then {
        $0.sizeToFit()
        $0.tintColor = .warmBlack
        $0.setImage(UIImage(systemName: "safari", withConfiguration: configuration), for: .normal)
        $0.addTarget(self, action: #selector(weatherButtondidTap(_:)), for: .touchUpInside)
    }
    
    private lazy var locationListButton = UIButton().then {
        $0.sizeToFit()
        $0.tintColor = .warmBlack
        $0.setImage(UIImage(systemName: "location.viewfinder", withConfiguration: configuration), for: .normal)
        $0.addTarget(self, action: #selector(locationButtondidTap(_:)), for: .touchUpInside)
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

extension ToolBar {
    
    private func setupViews() {
        barTintColor = .white
        addSubviews([weatherButton, locationListButton])
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        weatherButton
            .centerYAnchor(to: centerYAnchor)
            .leadingAnchor(to: safeAreaLayoutGuide.leadingAnchor, constant: UI.basicMargin)
            .activateAnchors()

        locationListButton
            .centerYAnchor(to: centerYAnchor)
            .trailingAnchor(to: safeAreaLayoutGuide.trailingAnchor, constant: -UI.basicMargin)
            .activateAnchors()
    }
}

//MARK: - Selector

extension ToolBar {
    
    @objc private func weatherButtondidTap(_ sender: UIButton) {
        
        if let weatherButtonDidTap = weatherButtonDidTap {
            weatherButtonDidTap()
        }
    }
    
    @objc private func locationButtondidTap(_ sender: UIButton) {
        
        if let locationListButtonDidTap = settingButtonDidTap {
          locationListButtonDidTap()
        }
    }
}

