//
//  BaseViewController.swift
//  Weather
//
//  Created by Ted on 2021/08/11.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

//MARK: - Setup Views

extension BaseViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        
        configureSubViews()
        setupConstraints()
    }
    
    private func configureSubViews() {
        
    }
}

//MARK: - Layout & Constraints

extension BaseViewController {
    
    //UI Metrics
    
    private struct UI {
        
    }
    
    //Setup Constraints
    
    private func setupConstraints() {
    }
    
}

