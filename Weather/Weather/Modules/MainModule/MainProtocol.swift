//
//  MainProtocol.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainProtocol {
    
    func setupUIBinding(with viewModel: [WeatherViewModel], cityName: String)
    func setupUIBinding(with viewModel: WeatherDailyViewModel)
    func setupUIBinding(with viewModel: WeatherInfoViewModel)
    func reloadCollectionView()
    func showAlert(withMessage message: String, animated: Bool) 
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    
    var view: PresenterToViewMainProtocol? { get set }
    var interactor: PresenterToInteractorMainProtocol? { get set }
    var router: PresenterToRouterMainProtocol? { get set }
    
    func viewWillAppear()
    func viewDidAppear()
    func weatherButtonClicked()
    func locationListButtonClicked()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    
    var presenter: InteractorToPresenterMainProtocol? { get set }
    
    func fetchWeatherData()
}


// MARK: Interactor Output (Interactor -> Presenter)

protocol InteractorToPresenterMainProtocol {
    
    func handleResult(_ result: WeatherResponse, cityName: String)
    func handleError(_ error: WeatherServiceError)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {
    func openWeatherWebsite()
    func pushToSettingViewController(view: PresenterToViewMainProtocol?)
}
