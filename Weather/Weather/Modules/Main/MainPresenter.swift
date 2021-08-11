//
//  MainPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainPresenter {

    // MARK: Properties
    var view: PresenterToViewMainProtocol?
    var interactor: PresenterToInteractorMainProtocol?
    var router: PresenterToRouterMainProtocol?

}

extension MainPresenter: ViewToPresenterMainProtocol {
    
    func viewDidLoad() {
        //fetch the data If needed
    }
    
    func viewDidAppear() {
        //request Location Authorization If needed
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    

}
