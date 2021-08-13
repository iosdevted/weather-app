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
        static let headerViewHeightRatio = CGFloat(0.4)
        static let hourlyCellHeightRatio = CGFloat(0.1)
    }
    
    //MARK: - Properties
    
    var presenter: ViewToPresenterMainProtocol?
    
    private let headerView = HeaderView()
    private var alertView: UIAlertController?
    private lazy var collectionView: CollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height * UI.hourlyCellHeightRatio)
        let view = CollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
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
        view.addSubviews([headerView, collectionView])
    }
    
    //MARK: - Layout & Constraints
    
    override func setupConstraints() {
        headerView
            .leadingAnchor(to: view.leadingAnchor)
            .trailingAnchor(to: view.trailingAnchor)
            .topAnchor(to: view.topAnchor)
            .heightAnchor(constant: UIScreen.main.bounds.height * UI.headerViewHeightRatio)
            .activateAnchors()
        
        collectionView
            .leadingAnchor(to: view.leadingAnchor)
            .trailingAnchor(to: view.trailingAnchor)
            .topAnchor(to: headerView.bottomAnchor)
            .bottomAnchor(to: view.bottomAnchor)
            .activateAnchors()
    }
}

extension MainViewController: PresenterToViewMainProtocol{
    
    //MARK: - Binding
    
    func bindToViews(with data: [WeatherModel]) {
        DispatchQueue.main.async {
            guard let recentData = data.first else { return }
            self.headerView.configureView(image: recentData.conditionImage,
                                          cityName: "Paris, France",
                                          currentTemperature: recentData.temp,
                                          description: recentData.description)
            
            self.collectionView.hourlyCollectionDidLoad = { header in
                header.hourlyCollectionView.reloadData()
                header.hourlyCollectionView.hourlyCellDidLoad = { cell, indexPath in
                    cell.configureCell(hour: data[indexPath.item].hour,
                                       image: data[indexPath.item].conditionImage,
                                       temp: data[indexPath.item].temp)
                }
            }
            
            self.collectionView.dailyCollectionDidLoad = { daily in
                daily.dailyCollectionView.reloadData()
                daily.dailyCollectionView.dailyCellDidLoad = { cell, indexPath in
                    cell.configureCell(day: data[indexPath.item].day,
                                       image: data[indexPath.item].conditionImage,
                                       maxTemp: data[indexPath.item].temp_max,
                                       minTemp: data[indexPath.item].temp_min)
                }
            }
            
            
            
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Show Alert
    
    func showAlert(withMessage message: String, animated: Bool) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertView = alert
        
        present(alert, animated: animated, completion: nil)
    }
}
