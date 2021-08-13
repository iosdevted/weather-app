//
//  SubInfoCell.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class SubInfoCell: UICollectionViewCell {
    
    private struct UI {
        static let margin = CGFloat(10)
    }
    
    //MARK: - Properties
    
    lazy var subInfoCollectionView: SubInfoCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = SubInfoCollectionView(frame: .zero, collectionViewLayout: layout)
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

extension SubInfoCell {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        addSubview(subInfoCollectionView)
    }
}

//MARK: - Layout & Constraints

extension SubInfoCell {
    
    private func setupConstraints() {
        
        subInfoCollectionView
            .topAnchor(to: topAnchor)
            .leadingAnchor(to: leadingAnchor, constant: UI.margin)
            .trailingAnchor(to: trailingAnchor, constant: -UI.margin)
            .bottomAnchor(to: bottomAnchor)
            .activateAnchors()
    }
}


