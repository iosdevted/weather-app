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
        static let basicMargin = CGFloat(10)
    }
    
    //MARK: - Properties
    
    private lazy var separateLineView = SeparateLineView()
    private lazy var descriptionLabel = UILabel().then {
        $0.textColor = .warmBlack
        $0.font = .summaryBoldFont()
        $0.numberOfLines = 0
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

extension SummaryCell {
    
    private func setupViews() {
        backgroundColor = .clear
        addSubviews([descriptionLabel, separateLineView])
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        descriptionLabel
            .leadingAnchor(to: leadingAnchor, constant: UI.basicMargin)
            .trailingAnchor(to: trailingAnchor, constant: -UI.basicMargin)
            .topAnchor(to: topAnchor, constant: UI.basicMargin)
            .bottomAnchor(to: bottomAnchor, constant: -UI.basicMargin)
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

