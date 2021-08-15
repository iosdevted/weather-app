//
//  SubInfoCollectionView.swift
//  Weather
//
//  Created by Ted on 2021/08/13.
//

import UIKit

class SubInfoCollectionView: UICollectionView {
    
    //MARK: - CallBack
    
    var collectionCellDidLoad: ((SubInfoCollectionCell, IndexPath) -> Void)?
    
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

extension SubInfoCollectionView {
    
    private func setupViews() {
        backgroundColor = .clear
        allowsSelection = false
        isScrollEnabled = false
        dataSource = self
        delegate = self
        register(cell: SubInfoCollectionCell.self)
    }
}

//MARK: - UICollectionViewDataSource

extension SubInfoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(SubInfoCollectionCell.self, indexPath)
        
        if let collectionCellDidLoad = collectionCellDidLoad {
            collectionCellDidLoad(cell, indexPath)
        } else {
            return cell
        }
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SubInfoCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2,
                      height: frame.height / 3)
    }
}
