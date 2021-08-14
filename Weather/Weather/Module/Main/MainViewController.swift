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

extension MainViewController: PresenterToViewMainProtocol {
    
    //MARK: <- View / Binding
    
    func bindToViews(with viewModel: [WeatherViewModel]) {
        DispatchQueue.main.async {
            self.headerView.configureView(viewModel: viewModel)
            self.collectionView.hourlyCollectionDidLoad = { header in
                header.hourlyCollectionView.hourlyCellDidLoad = { cell, indexPath in
                    cell.configureCell(viewModel: viewModel, item: indexPath.item)
                }
                header.hourlyCollectionView.reloadData()
            }
        }
    }
    
    func bindToViews(with viewModel: WeatherDailyViewModel) {
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
    
    func bindToViews(with viewModel: WeatherInfoViewModel) {
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
    
    //MARK: Show Alert
    
    func showAlert(withMessage message: String, animated: Bool) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertView = alert
        
        present(alert, animated: animated, completion: nil)
    }
}
