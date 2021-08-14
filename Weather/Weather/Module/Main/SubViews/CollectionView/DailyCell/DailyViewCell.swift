//
//  DailyViewCell.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class DailyViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let separateLineView = SeparateLineView()
    lazy var dailyCollectionView: DailyCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        let view = DailyCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
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

extension DailyViewCell {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        addSubviews([dailyCollectionView, separateLineView])
    }
}

//MARK: - Layout & Constraints

extension DailyViewCell {
    
    private func setupConstraints() {
        
        dailyCollectionView
            .topAnchor(to: topAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .bottomAnchor(to: bottomAnchor)
            .activateAnchors()

        separateLineView
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .setupConstraints(bottom: dailyCollectionView.bottomAnchor)
    }
}


