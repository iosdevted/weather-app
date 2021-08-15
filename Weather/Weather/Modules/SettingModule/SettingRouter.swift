//
//  SettingRouter.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//  
//

import Foundation
import UIKit

class SettingRouter: PresenterToRouterSettingProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = SettingViewController()
        
        let presenter: ViewToPresenterSettingProtocol & InteractorToPresenterSettingProtocol = SettingPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SettingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func popToRootViewController(view: PresenterToViewSettingProtocol?) {
        
        let viewController = view as! SettingViewController
        viewController.navigationController?.popToRootViewController(animated: true)
    }
    
}
