//
//  ListProtocol.swift
//  Weather
//
//  Created by Ted on 2021/08/14.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewListProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterListProtocol {
    
    var view: PresenterToViewListProtocol? { get set }
    var interactor: PresenterToInteractorListProtocol? { get set }
    var router: PresenterToRouterListProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorListProtocol {
    
    var presenter: InteractorToPresenterListProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterListProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterListProtocol {
    
}
