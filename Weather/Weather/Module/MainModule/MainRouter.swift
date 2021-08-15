//
//  MainRouter.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import UIKit

class MainRouter: PresenterToRouterMainProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = MainViewController()
        
        let presenter: ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = MainRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MainInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func openWeatherWebsite() {
        guard let url = URL(string: "https://weather.com/"),
              UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func pushToSettingViewController(view: PresenterToViewMainProtocol?) {
        let settingViewController = SettingRouter.createModule()
        
        let viewController = view as! MainViewController
//        viewController.present(settingViewController, animated: true, completion: nil)
        viewController.navigationController?
            .pushViewController(settingViewController, animated: true)
    }
}
