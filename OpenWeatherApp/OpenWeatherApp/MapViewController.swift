//
//  MapViewController.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 7/1/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    let locationManager = CLLocationManager()
    var matchingItems:[MKMapItem] = []
    
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        //configure placeholder
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search location", attributes: [NSAttributedString.Key.foregroundColor: UIColor.label])
        
        searchController.searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.searchBarStyle = .default
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mainView)
        mainView.frame = self.view.frame
        mainView.addSubview(mapView)
                
        configureNavBar()
        makeConstraints()
        
        searchController.searchResultsUpdater = self
    }
    
    private func makeConstraints(){
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mapView.contentHuggingPriority(for: .vertical)
    }
    
    //MARK: - Configure NavBar
    func configureNavBar() {
        navigationItem.searchController = searchController
    }
}

extension MapViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      guard let searchBarText = searchController.searchBar.text else { return }
      let request = MKLocalSearch.Request()
      request.naturalLanguageQuery = searchBarText
      request.region = mapView.region
      let search = MKLocalSearch(request: request)
      search.start { response, _ in
          guard let response = response else {
              return
          }
          self.matchingItems = response.mapItems
          print(self.matchingItems)
      }
  }
}


