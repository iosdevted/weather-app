//
//  UICollectionView+Reusable.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
    
}
// id 값을 자신의 타입 이름으로 설정되도록 하기 (class SomeCell: UITableViewCell 의 id 는 SomeCell)
extension Identifiable {
    public static var identifier: String {
        return String(describing: self)
    }
}

//extension UICollectionViewCell: Identifiable { }
extension UICollectionReusableView: Identifiable { }

// register : 타입만 받아서 cell 간편하게 등록해줌
// dequeue : as? 쓰지 않아도 자기 자신의 타입과 cell id 로 자동으로 반환하게 해주는 아이
extension UICollectionView {
    func register<Cell> (
        // regiser 가 제네릭 타입 이라 Identifiable 프로토콜 을 채택하지 않은 Cell 이 들어올 수 있는 변수 때문에 where 로 제한할 것.
        cell: Cell.Type,
        forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeue<Cell>(
        _ reusableCell: Cell.Type,
        _ indexpath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: reusableCell.identifier, for: indexpath) as? Cell else { fatalError("Could not find cell with identifier") }
        return cell
    }
}

