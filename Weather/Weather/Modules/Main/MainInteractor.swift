//
//  MainInteractor.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation

class MainInteractor {

    // MARK: Properties
    var presenter: InteractorToPresenterMainProtocol?
}

extension MainInteractor: PresenterToInteractorMainProtocol {
    
}
