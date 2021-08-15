//
//  SettingContract.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//  
//

import UIKit


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSettingProtocol {
   func reloadTableView()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSettingProtocol {
    
    var view: PresenterToViewSettingProtocol? { get set }
    var interactor: PresenterToInteractorSettingProtocol? { get set }
    var router: PresenterToRouterSettingProtocol? { get set }
    
    func viewDidLoad()
    func numberOfRows(in section: Int) -> Int
    func configureCell(_ cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func didSelectTableViewRow(at indexPath: IndexPath)
    func textDidChange(searchText: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSettingProtocol {
    
    var presenter: InteractorToPresenterSettingProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSettingProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSettingProtocol {
    func popToViewController(view: PresenterToViewSettingProtocol?)
}
