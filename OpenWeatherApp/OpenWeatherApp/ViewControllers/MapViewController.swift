//  MapViewController.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 7/1/23.
//
import UIKit
import MapKit
import CoreLocation

protocol LocationSearchControllerProtocol {
    func setCityOnMap(placemark: MKPlacemark)
}
protocol UpdateLocationFromMap: AnyObject {
    var placemark: MKPlacemark? {get set}
}

class MapViewController: UIViewController, UISearchControllerDelegate {
    //MARK: - Variables
    let locationService = CLLocationManager()
    let locationSearchTable = SearchResultTableViewController()

    var city: MKPlacemark?
    weak var delegate: UpdateLocationFromMap?
    
    //MARK: - Create UI components
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: locationSearchTable)
        searchController.searchResultsUpdater = locationSearchTable
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
    
    //MARK: - Constraints
    private func makeConstraints(){
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mapView.contentHuggingPriority(for: .vertical)
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        locationSearchTable.delegate = self
        searchController.delegate = self

        view.addSubview(mapView)
        makeConstraints()
        
        getLocation()
    }
    
    //MARK: - Configure NavBar
    func configureNavBar() {
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleSaveButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    //MARK: - NavBar Selectors
    @objc func handleSaveButton() {
        guard let city = city else { return }
        delegate?.placemark = city
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extensions
extension MapViewController: CLLocationManagerDelegate {
    private func getLocation() {
        self.locationService.requestAlwaysAuthorization()
        self.locationService.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async {
            if !CLLocationManager.locationServicesEnabled() {
                return
            }
        }

        locationService.delegate = self
        locationService.desiredAccuracy = kCLLocationAccuracyBest
        locationService.requestWhenInUseAuthorization()
        locationService.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
        guard let currentLocation = locationService.location?.coordinate else { return }
        self.locationService.stopUpdatingLocation()
        
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: currentLocation, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

extension MapViewController: LocationSearchControllerProtocol {
    func setCityOnMap(placemark: MKPlacemark) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: false)
        navigationItem.rightBarButtonItem?.isEnabled = true
        self.city = placemark
    }
}
