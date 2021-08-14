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
        guard let url = URL(string: "https://weather.com/weather/today/l/1a8af5b9d8971c46dd5a52547f9221e22cd895d8d8639267a87df614d0912830"),
              UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func pushListViewController(view: PresenterToViewMainProtocol) {
        let listViewController = ListRouter.createModule()
        
        let viewController = view as! MainViewController
        viewController.navigationController?
            .pushViewController(listViewController, animated: true)
    }
}
