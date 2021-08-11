//
//  MainPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainPresenter: ViewToPresenterMainProtocol {

    // MARK: Properties
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    
}
