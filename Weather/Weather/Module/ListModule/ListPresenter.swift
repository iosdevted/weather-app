//
//  ListPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/14.
//  
//

import Foundation

class ListPresenter: ViewToPresenterListProtocol {

    // MARK: Properties
    var view: PresenterToViewListProtocol?
    var interactor: PresenterToInteractorListProtocol?
    var router: PresenterToRouterListProtocol?
}

extension ListPresenter: InteractorToPresenterListProtocol {
    
}
