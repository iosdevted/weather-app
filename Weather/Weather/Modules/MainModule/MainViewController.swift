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
        static let headerViewHeightRatio = CGFloat(0.38)
        static let hourlyCellHeightRatio = CGFloat(0.12)
    }
    
    //MARK: - Properties
    
    var presenter: ViewToPresenterMainProtocol?
    
    private lazy var headerView = HeaderView()
    private lazy var toolBar = ToolBar()
    private lazy var collectionView: CollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height * UI.hourlyCellHeightRatio)
        let view = CollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    private var alertView: UIAlertController?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupEventBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    //MARK: - Setup Views
    
    override func setupViews() {
        view.backgroundColor = .white
        view.addSubviews([headerView, collectionView, toolBar])
        setupConstraints()
    }
    
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
            .activateAnchors()
        
        toolBar
            .leadingAnchor(to: view.safeAreaLayoutGuide.leadingAnchor)
            .trailingAnchor(to: view.safeAreaLayoutGuide.trailingAnchor)
            .topAnchor(to: collectionView.bottomAnchor)
            .bottomAnchor(to: view.safeAreaLayoutGuide.bottomAnchor)
            .activateAnchors()
    }
}

extension MainViewController {
    
    //MARK: -> Presenter / EventBinding
    
    func setupEventBinding() {
        
        toolBar.weatherButtonDidTap = {
            self.presenter?.weatherButtonClicked()
        }
        
        toolBar.settingButtonDidTap = {
            self.presenter?.settingButtonClicked()
        }
    }
}

extension MainViewController: PresenterToViewMainProtocol {
    
    //MARK: UI Binding / View <-
    
    func setupUIBinding(with viewModel: [WeatherViewModel], cityName: String) {
        DispatchQueue.main.async {
            self.headerView.configureView(viewModel: viewModel, cityName: cityName)
            self.collectionView.hourlyCollectionDidLoad = { header in
                header.hourlyCollectionView.hourlyCellDidLoad = { cell, indexPath in
                    cell.configureCell(viewModel: viewModel, item: indexPath.item)
                }
                header.hourlyCollectionView.reloadData()
            }
        }
    }
    
    func setupUIBinding(with viewModel: WeatherDailyViewModel) {
        DispatchQueue.main.async {
            self.collectionView.dailyCollectionDidLoad = { daily in
                daily.dailyCollectionView.dailyCellDidLoad = { cell, indexPath in
                    cell.configureCell(viewModel: viewModel, item: indexPath.item)
                }
                daily.dailyCollectionView.reloadData()
            }
            
            self.collectionView.summaryCollectionDidLoad = { summary in
                summary.configureCell(viewModel: viewModel)
            }
        }
    }
    
    func setupUIBinding(with viewModel: WeatherInfoViewModel) {
        DispatchQueue.main.async {
            self.collectionView.SubInfoCollectionDidLoad = { subInfo in
                subInfo.subInfoCollectionView.collectionCellDidLoad = { cell, indexPath in
                    cell.configureCell(viewModel: viewModel, item: indexPath.item)
                }
                subInfo.subInfoCollectionView.reloadData()
            }
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showAlert(withMessage message: String, animated: Bool) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertView = alert
        
        present(alert, animated: animated, completion: nil)
    }
}
