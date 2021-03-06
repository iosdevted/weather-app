//
//  DailyCollectionView.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import UIKit

class DailyCollectionView: UICollectionView {
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let numberOfItemsInSection = Int(6)
    }
    
    //MARK: - CallBack
    
    var dailyCellDidLoad: ((DailyCollectionCell, IndexPath) -> Void)?
    
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

extension DailyCollectionView {
    
    private func setupViews() {
        backgroundColor = .clear
        allowsSelection = false
        dataSource = self
        delegate = self
        register(cellType: DailyCollectionCell.self)
    }
}

//MARK: - UICollectionViewDataSource

extension DailyCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UI.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: DailyCollectionCell.self)
        
        if let dailyCellDidLoad = dailyCellDidLoad {
            dailyCellDidLoad(cell, indexPath)
        } else {
            return cell
        }
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension DailyCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: frame.height / CGFloat(UI.numberOfItemsInSection))
    }
}
