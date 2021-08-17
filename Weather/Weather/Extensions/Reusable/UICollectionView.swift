//
//  UICollectionView+Reusable.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

extension UICollectionReusableView: Reusable {}
// We need to adopt Reusable for "forCellWithReuseIdentifier".

extension UICollectionView {
    
    // register : Don't have to write "forCellWithReuseIdentifier" every time
    // dequeue : Don't have to wrtie "as?" every time.
    
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
}

