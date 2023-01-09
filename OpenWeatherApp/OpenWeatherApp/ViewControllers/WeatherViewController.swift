//  WeatherViewController.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 5/1/23.
//
import UIKit
import CoreLocation

protocol WeatherDisplayLogic: AnyObject {
    func displayData(viewModel: WeatherRouter.ViewModel.ViewModelData)
}

protocol WeatherControllerDelegate: AnyObject {
    func handleMapButtonPressed()
    func handleCurrentLocationPressed()
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    let weatherView = MainScrollView()
    var interactor: (LocationServiceProtocol & UpdateLocationFromMap)?
    
    // MARK: - Setup
    private func setup() {
        let viewController        = self
        let interactor            = LocationService.shared
        let presenter             = WeatherPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureNavBar(location: "-")
        
        view.addSubview(weatherView)
        makeConstraints()
        interactor?.isLocationOrMap = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //Check show current location or location from the map
        guard let isLocationOrMap = interactor?.isLocationOrMap else {return}
        isLocationOrMap ? interactor?.makeRequest(request: .getCurrentWeather) : interactor?.makeRequest(request: .getCityWeather)
    }
    
    //MARK: - Constraints
    private func makeConstraints(){
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        weatherView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        weatherView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    //MARK: - displayData
    func displayData(viewModel: WeatherRouter.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeather(let currentWeatherViewModel):
            weatherView.configure(viewModel: currentWeatherViewModel)
                guard let titleLabel = navigationItem.titleView as? UILabel else { return }
                titleLabel.text = currentWeatherViewModel.locality
        }
    }
    
    //MARK: - Configure NavBar
    func configureNavBar(location: String) {
        navigationController?.navigationBar.backgroundColor = self.weatherView.backgroundColor
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = AssetsColor.primaryBackground.color
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        //Left NavBar title config
        let leftNavBarInsect = 30
        let leftNavBarTitle = UILabel(frame: CGRect(
                                                x: 0,
                                                y: 0,
                                                width: view.frame.width - CGFloat(leftNavBarInsect),
                                                height: view.frame.height))
        leftNavBarTitle.text = "-"
        leftNavBarTitle.textColor = .white
        leftNavBarTitle.font = UIFont.systemFont(ofSize: 35)
        navigationItem.titleView = leftNavBarTitle

        //Left NavBar button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handleMapButtonPressed))
        //Right NavBar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleCurrentLocationPressed))
    }
}

extension WeatherViewController: WeatherControllerDelegate {
    // MARK: - NavBar Selectors
    @objc func handleMapButtonPressed() {
        interactor?.isLocationOrMap = false
        let vc = MapViewController()
            navigationController?.pushViewController(vc, animated: true)
        vc.delegate = interactor
    }
    
    @objc func handleCurrentLocationPressed() {
        interactor?.makeRequest(request: .getCurrentWeather)
        interactor?.isLocationOrMap = true
    }
}
