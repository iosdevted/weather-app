//
//  HourlyCollectionView.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class HourlyCollectionView: UICollectionView {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let cellWidth = CGFloat(65)
    }
    
    //MARK: - CallBack
    
    var hourlyCellDidLoad: ((HourlyCollectionCell, IndexPath) -> Void)?
    
    //MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: - Setup Views

extension HourlyCollectionView {
    
    private func setupViews() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
        register(cellType: HourlyCollectionCell.self)
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension HourlyCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HourlyCollectionCell.self)
        
        if let hourlyCellDidLoad = self.hourlyCellDidLoad {
            hourlyCellDidLoad(cell, indexPath)
        } else {
            return cell
        }
        
        return cell
    }
}

extension HourlyCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UI.cellWidth, height: self.frame.height)
    }
}


