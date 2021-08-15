//
//  SubInfoCell.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class SubInfoCell: UICollectionViewCell {
    
    private struct UI {
        static let basicMargin = CGFloat(10)
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
        addSubview(subInfoCollectionView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        subInfoCollectionView
            .topAnchor(to: topAnchor)
            .leadingAnchor(to: leadingAnchor, constant: UI.basicMargin)
            .trailingAnchor(to: trailingAnchor, constant: -UI.basicMargin)
            .bottomAnchor(to: bottomAnchor)
            .activateAnchors()
    }
}

