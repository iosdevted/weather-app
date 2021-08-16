//
//  SettingInteractor.swift
//  Weather
//
//  Created by Ted on 2021/08/15.
//  
//

import MapKit
import Foundation

class SettingInteractor: NSObject {

    // MARK: Properties
    var presenter: InteractorToPresenterSettingProtocol?
    
    private var searchResults = [MKLocalSearchCompletion]()
    private var searchCompleter = MKLocalSearchCompleter()
}

//MARK: -> Interactor

extension SettingInteractor: PresenterToInteractorSettingProtocol {
    func deliverDelegate() {
        searchCompleter.delegate = self
    }
    
    // numberOfRows
    func locationSearchResultsCount() -> Int {
        return searchResults.count
    }
    
    // configureCell
    func searchResultsText(indexPath: IndexPath) -> String {
        let searchResult = searchResults[indexPath.row]
        return searchResult.title
    }
    
    // didSelectTableViewRow
    func saveSelectedLocationData(indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard error == nil else { return }
            guard let placeMark = response?.mapItems[0].placemark else { return }
            guard let locationName = placeMark.name else { return }
             
            let location = Location(name: locationName, latitude: placeMark.coordinate.latitude, longitude: placeMark.coordinate.longitude)
            // Delete All local data and Save Only Location Data (No Weather Data)
            RealmManager.shared.saveOnlyLocationData(location)
            self.presenter?.popToRootViewController()
        }
    }
    
    // textDidChange
    func enterQueryFragment(with searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
            presenter?.reloadTableView()
        }
        // The text entered by the user in the search bar is put into the auto-completion target.
        searchCompleter.queryFragment = searchText
    }
}

//MARK: - MKLocalSearchCompleterDelegate

extension SettingInteractor: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // update search results
        searchResults = completer.results
        presenter?.reloadTableView()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Cancel")
    }
}

