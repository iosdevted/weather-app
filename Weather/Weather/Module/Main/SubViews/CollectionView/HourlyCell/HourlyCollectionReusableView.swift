//
//  HourlyCollectionReusableView.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class HourlyCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    
    private let separateLineView = SeparateLineView(frame: .zero)
    lazy var hourlyCollectionView: HourlyCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let view = HourlyCollectionView(frame: .zero, collectionViewLayout: layout)
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

extension HourlyCollectionReusableView {
    
    private func setupViews() {
        backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
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

