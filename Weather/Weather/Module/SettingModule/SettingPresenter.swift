//
//  SettingPresenter.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//  
//

import MapKit
import Then
import Foundation

class SettingPresenter: NSObject {
    
    // MARK: Properties
    
    var view: PresenterToViewSettingProtocol?
    var interactor: PresenterToInteractorSettingProtocol?
    var router: PresenterToRouterSettingProtocol?
    
    private var searchResults = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter().then {
        $0.filterType = .locationsOnly
    }
}

extension SettingPresenter: ViewToPresenterSettingProtocol {
    func viewDidLoad() {
        searchCompleter.delegate = self
    }
    
    func numberOfRows(in section: Int) -> Int {
        return searchResults.count
    }
    
    func configureCell(_ cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let searchResult = searchResults[indexPath.row]
        
        
        
        cell.textLabel?.text = searchResult.title
    }
    
    func didSelectTableViewRow(at indexPath: IndexPath) {
        
        
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                print("")
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            
            guard let locationName = placeMark.name else { return }
            
            let location = Location(location: locationName, latitude: placeMark.coordinate.latitude, longitude: placeMark.coordinate.longitude)
            RealmManager.shared.saveLocation(location)
            
        }
        
        router?.popToViewController(view: view)
    }
    
    func textDidChange(searchText: String) {
        
        
        
        if searchText == "" {
            searchResults.removeAll()
            view?.reloadTableView()
        }
        // 사용자가 search bar 에 입력한 text를 자동완성 대상에 넣는다
        searchCompleter.queryFragment = searchText
    }
}

extension SettingPresenter: InteractorToPresenterSettingProtocol {
    
    
}


//MARK: - MKLocalSearchCompleterDelegate

extension SettingPresenter: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        view?.reloadTableView()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("failed")
    }
}
