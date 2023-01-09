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
protocol Update: AnyObject {
    var placemark: MKPlacemark? {get set}
}

class MapViewController: UIViewController {
    //MARK: - Variables
    let locationManager = CLLocationManager()
    let locationSearchTable = SearchResultTableViewController()

    var city: MKPlacemark?
    var delegate: Update?
    
    @objc func handleSaveButton() {
        guard let city = city else { return }
        delegate?.placemark = city
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Create UI components
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    // Constraints
    private func makeConstraints(){
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mapView.contentHuggingPriority(for: .vertical)
    }
    
    // Configure NavBar
    func configureNavBar() {
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleSaveButton))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(handleSaveButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        locationSearchTable.delegate = self

        view.addSubview(mainView)
        mainView.frame = self.view.frame
        mainView.addSubview(mapView)
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getLocation()
    }
}

//MARK: - Extensions
extension MapViewController: CLLocationManagerDelegate {
    private func getLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
        guard let currentLocation = locationManager.location?.coordinate else { return }
        self.locationManager.stopUpdatingLocation()
        
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
