//
//  SummaryCell.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Then
import UIKit

class SummaryCell: UICollectionViewCell {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let margin = CGFloat(10)
    }
    
    //MARK: - Properties
    
    private let descriptionLabel = UILabel()
    private let separateLineView = SeparateLineView()
    
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

extension SummaryCell {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        descriptionLabel.do {
            $0.textColor = .warmBlack
            $0.font = .summaryBoldFont()
            $0.numberOfLines = 0
        }
        
        addSubviews([descriptionLabel, separateLineView])
    }
}

//MARK: - Layout & Constraints

extension SummaryCell {
    
    private func setupConstraints() {
        
        descriptionLabel
            .leadingAnchor(to: leadingAnchor, constant: UI.margin)
            .trailingAnchor(to: trailingAnchor, constant: -UI.margin)
            .topAnchor(to: topAnchor, constant: UI.margin)
            .bottomAnchor(to: bottomAnchor, constant: -UI.margin)
            .activateAnchors()
        
        separateLineView
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .setupConstraints(bottom: bottomAnchor)
    }
}

//MARK: - Configure Cell

extension SummaryCell {
    
    func configureCell(viewModel: WeatherDailyViewModel) {
        descriptionLabel.text = "Today: Mostly \(viewModel.conditionImage[0]). The high today was forecast as \(viewModel.temp_max[0])"
    }
}

