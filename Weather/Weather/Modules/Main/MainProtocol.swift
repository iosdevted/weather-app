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
    func bindToViews(with data: MainWeatherModel)
    func showAlert(withMessage message: String, animated: Bool) 
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    
    var view: PresenterToViewMainProtocol? { get set }
    var interactor: PresenterToInteractorMainProtocol? { get set }
    var router: PresenterToRouterMainProtocol? { get set }
    
    func viewDidLoad()
    func viewDidAppear()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    
    var presenter: InteractorToPresenterMainProtocol? { get set }
    
    func fetchWeatherData()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol {
    
    func handleResult(_ result: Result<MainWeatherModel, WeatherServiceError>)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {
    
}
