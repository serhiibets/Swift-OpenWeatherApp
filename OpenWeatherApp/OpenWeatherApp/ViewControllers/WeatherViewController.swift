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
    let weatherView = WeatherView()
    var interactor: LocationServiceProtocol?
    
    // MARK: - Setup
    private func setup() {
        let viewController        = self
        let interactor            = LocationService()
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
        weatherView.frame = self.view.frame
        view.backgroundColor = AppStyle.light.primaryBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        interactor?.makeRequest(request: .getWeather)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        weatherView.contentSize = CGSize(width:self.view.bounds.width, height: 845)
    }
    
    //MARK: - displayData
    func displayData(viewModel: WeatherRouter.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayWeather(let currentWeatherViewModel):
            weatherView.configure(viewModel: currentWeatherViewModel)
        }
    }
    
    //MARK: - Configure NavBar
    func configureNavBar(location: String) {
        navigationController?.navigationBar.backgroundColor = self.weatherView.backgroundColor
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = AppStyle.light.primaryBackgroundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        //Left NavBar title config
        let leftNavBarInsect = 30
        let leftNavBarTitle = UILabel(frame: CGRect(
                                                x: 0,
                                                y: 0,
                                                width: view.frame.width - CGFloat(leftNavBarInsect),
                                                height: view.frame.height))
        leftNavBarTitle.text = "Бенідорм"
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
        let vc = MapViewController()
            navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleCurrentLocationPressed() {
        interactor?.makeRequest(request: .getWeather)
    }
}
