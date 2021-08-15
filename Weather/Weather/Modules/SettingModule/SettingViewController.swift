//
//  SettingViewController.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//  
//

import Then
import UIKit

class SettingViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: ViewToPresenterSettingProtocol?
    
    private lazy var searchBar = UISearchBar().then {
        $0.placeholder = "Enter city, zip, code, or airport location"
        $0.tintColor = .warmBlack
    }
    
    private lazy var searchTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    //MARK: - Setup Views
    
    func setupViews() {
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(cell: UITableViewCell.self)
        
        view.backgroundColor = .white
        view.addSubviews([searchBar, searchTableView])
        setupConstraints()
    }
    
    func setupConstraints() {
        searchBar
            .topAnchor(to: view.safeAreaLayoutGuide.topAnchor)
            .leadingAnchor(to: view.leadingAnchor)
            .trailingAnchor(to: view.trailingAnchor)
            .heightAnchor(constant: 60)
            .activateAnchors()
        
        searchTableView
            .topAnchor(to: searchBar.bottomAnchor)
            .leadingAnchor(to: view.leadingAnchor)
            .trailingAnchor(to: view.trailingAnchor)
            .bottomAnchor(to: view.bottomAnchor)
            .activateAnchors()
    }
}

//MARK: -> Presenter

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self)
        presenter?.configureCell(cell, forRowAt: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectTableViewRow(at: indexPath)
    }
}

extension SettingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.textDidChange(searchText: searchText)
    }
}

//MARK: View <-

extension SettingViewController: PresenterToViewSettingProtocol{
   
    func reloadTableView() {
        searchTableView.reloadData()
    }
}


