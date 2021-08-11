//
//  MainViewController.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import UIKit

class MainViewController: BaseViewController {
    
    //MARK: - UI Metrics
    
    private struct UI {
        
        struct HeaderView {
            static let height = CGFloat(300)
        }
    }
    
    //MARK: - Properties
    
    var presenter: ViewToPresenterMainProtocol?
    
    private let headerView = HeaderView()
    private var alertView: UIAlertController?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    //MARK: - Setup Views
    
    override func setupViews() {
        view.backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    override func configureSubViews() {
        view.addSubviews([headerView])
    }
    
    //MARK: - Layout & Constraints
    
    override func setupConstraints() {
        headerView
            .leadingAnchor(to: view.leadingAnchor)
            .trailingAnchor(to: view.trailingAnchor)
            .topAnchor(to: view.topAnchor)
            .heightAnchor(constant: UI.HeaderView.height)
            .activateAnchors()
    }
}

extension MainViewController: PresenterToViewMainProtocol{

    func bindToViews(with data: MainWeatherModel) {
        DispatchQueue.main.async {
            self.headerView.configureView(image: data.conditionImage,
                                          cityName: data.cityName,
                                          currentTemperature: data.currentTemperature,
                                          description: data.weatherDescription)
        }
    }
    
    func showAlert(withMessage message: String, animated: Bool) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertView = alert

        present(alert, animated: animated, completion: nil)
    }
}
