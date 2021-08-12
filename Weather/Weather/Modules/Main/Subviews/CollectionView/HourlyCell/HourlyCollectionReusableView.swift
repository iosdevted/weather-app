//
//  HourlyCollectionReusableView.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import Then
import UIKit

class HourlyCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    
    var collectionViewLayout = UICollectionViewFlowLayout()
    var hourlyCollectionView: HourlyCollectionView!
    private let separateLineView = SeparateLineView(frame: .zero)
    
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

extension HourlyCollectionReusableView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
        collectionViewLayout.do {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            hourlyCollectionView = HourlyCollectionView(frame: .zero, collectionViewLayout: $0)
        }
        
        addSubviews([hourlyCollectionView, separateLineView])
    }
}

//MARK: - Layout & Constraints

extension HourlyCollectionReusableView {
    
    private func setupConstraints() {
        
        hourlyCollectionView
            .topAnchor(to: topAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .bottomAnchor(to: bottomAnchor)
            .activateAnchors()
        
        separateLineView
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .setupConstraints(bottom: hourlyCollectionView.bottomAnchor)
    }
}

