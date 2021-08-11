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
    
    //MARK: - Setup Views
    
    func setupViews() {
        configureSubViews()
        setupConstraints()
    }
    
    func configureSubViews() {
        
    }
    
    //MARK: - Layout & Constraints
    
    func setupConstraints() {
        
    }
}
