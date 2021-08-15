//
//  UITableView+Reusable.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//

import UIKit

protocol TableViewCellType {
    static var identifier: String { get }
}

extension UITableViewCell: TableViewCellType {
    static var identifier: String { return String(describing: self.self) }
}

extension UITableView {
    func register<Cell>(
        cell: Cell.Type,
        forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UITableViewCell {
        register(cell, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell where Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(
            withIdentifier: reusableCell.identifier
        ) as? Cell else { fatalError("Could not find cell with identifier") }
        return cell
    }
}
