//
//  ListRouter.swift
//  Weather
//
//  Created by Ted on 2021/08/14.
//  
//

import Foundation
import UIKit

class ListRouter: PresenterToRouterListProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = ListViewController()
        
        let presenter: ViewToPresenterListProtocol & InteractorToPresenterListProtocol = ListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
