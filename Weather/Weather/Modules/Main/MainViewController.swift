//
//  MainViewController.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//  
//

import UIKit

class MainViewController: BaseViewController {
    
    //MARK: - Properties
    
    var presenter: ViewToPresenterMainProtocol?
    
    private let headerView = HeaderView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

//MARK: - Setup Views

extension MainViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        view.addSubviews([headerView])
    }
}

//MARK: - Layout & Constraints

extension MainViewController {
    
    //UI Metrics
    
    private struct UI {
        
        struct HeaderView {
            static let height = CGFloat(300)
        }
    }
    
    //Setup Constraints
    
    private func setupConstraints() {
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
