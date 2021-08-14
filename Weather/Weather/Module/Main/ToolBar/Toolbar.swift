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
        
        static let margin = CGFloat(15)
    }
    
    // MARK: - Callback
    
    internal var weatherButtonDidTap: (() -> ())?
    internal var locationListButtonDidTap: (() -> ())?
    
    //MARK: - Properties
    
    private let weatherButton = UIButton()
    private let locationListButton = UIButton()
    
//    private let weatherButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(weatherButtondidTap(_:)))
//    private let locationListButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(locationButtondidTap(_:)))
//    private let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    
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
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        weatherButton.do {
            $0.setImage(UIImage(systemName: "safari", withConfiguration: UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .default)), for: .normal)
            $0.sizeToFit()
            $0.tintColor = .warmBlack
            $0.addTarget(self, action: #selector(weatherButtondidTap(_:)), for: .touchUpInside)
        }

        locationListButton.do {
            $0.setImage(UIImage(systemName: "list.dash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .default)), for: .normal)
            $0.sizeToFit()
            $0.tintColor = .warmBlack
            $0.addTarget(self, action: #selector(locationButtondidTap(_:)), for: .touchUpInside)
        }
        
        addSubviews([weatherButton, locationListButton])
        
        
        weatherButton.tintColor = .warmBlack
        locationListButton.tintColor = .warmBlack
        
//        setItems([weatherButton, flexibleSpace, flexibleSpace, flexibleSpace, locationListButton], animated: true)
    }
}

//MARK: - Layout & Constraints

extension ToolBar {
    
    private func setupConstraints() {
        
        weatherButton
            .centerYAnchor(to: centerYAnchor)
            .leadingAnchor(to: safeAreaLayoutGuide.leadingAnchor, constant: UI.margin)
            .activateAnchors()

        locationListButton
            .centerYAnchor(to: centerYAnchor)
            .trailingAnchor(to: safeAreaLayoutGuide.trailingAnchor, constant: -UI.margin)
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
        
        if let locationListButtonDidTap = locationListButtonDidTap {
          locationListButtonDidTap()
        }
    }
}

