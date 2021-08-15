//
//  SettingPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//  
//

import UIKit

class SettingPresenter {
    
    // MARK: Properties
    
    var view: PresenterToViewSettingProtocol?
    var interactor: PresenterToInteractorSettingProtocol?
    var router: PresenterToRouterSettingProtocol?

}

extension SettingPresenter: ViewToPresenterSettingProtocol {
    
    //MARK: -> Presenter
    
    func viewDidLoad() {
        interactor?.deliverDelegate()
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let numberOfRows = interactor?.locationSearchResultsCount() else { return 0 }
        return numberOfRows
    }
    
    func configureCell(_ cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = interactor?.searchResultsText(indexPath: indexPath)
    }
    
    func didSelectTableViewRow(at indexPath: IndexPath) {
        interactor?.saveSelectedLocationData(indexPath: indexPath)
    }
    
    func textDidChange(searchText: String) {
        interactor?.enterQueryFragment(with: searchText)
    }
}

extension SettingPresenter: InteractorToPresenterSettingProtocol {
    
    //MARK: Presenter <-
    
    func reloadTableView() {
        view?.reloadTableView()
    }
    
    func popToRootViewController() {
        router?.popToRootViewController(view: view)
    }
}
