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
    // TODO: Implement View Output Methods
}
