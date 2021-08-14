//
//  ListViewController.swift
//  Weather
//
//  Created by Ted on 2021/08/14.
//  
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    // MARK: - Properties
    var presenter: ViewToPresenterListProtocol?
    
}

extension ListViewController: PresenterToViewListProtocol{
    // TODO: Implement View Output Methods
}
