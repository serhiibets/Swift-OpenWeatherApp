//  LocationSearchTableViewController.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 8/1/23.
//
import UIKit
import MapKit

class SearchResultTableViewController : UITableViewController {
    var searchResults:[MKMapItem] = []
    var delegate: LocationSearchControllerProtocol?
}

extension SearchResultTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }

        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBarText
        searchRequest.region = MKCoordinateRegion(.world)
        let search = MKLocalSearch(request: searchRequest)
        searchRequest.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            self.searchResults = response.mapItems
            self.tableView.reloadData()
        }
    }
}

//MARK: - Extensions
extension SearchResultTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedItem = searchResults[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.setCityOnMap(placemark: searchResults[indexPath.row].placemark)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.isHidden = true
    }
}
