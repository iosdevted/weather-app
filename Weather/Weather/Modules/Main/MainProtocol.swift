//
//  MainProtocol.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    
    var view: PresenterToViewMainProtocol? { get set }
    var interactor: PresenterToInteractorMainProtocol? { get set }
    var router: PresenterToRouterMainProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    
    var presenter: InteractorToPresenterMainProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {
    
}
