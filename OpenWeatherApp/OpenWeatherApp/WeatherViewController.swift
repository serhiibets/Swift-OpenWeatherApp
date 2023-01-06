//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 5/1/23.
//

import UIKit
import CoreLocation

protocol WeatherDisplayLogic: AnyObject {
    func displayData(viewModel: WeatherEnumModel.ViewModel.ViewModelData)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    let weatherView = WeatherView()
    var interactor: WeatherBusinessLogic?
    
    // MARK: - Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = WeatherInteractor()
        let presenter             = WeatherPresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        view.addSubview(weatherView)
        weatherView.frame = self.view.frame
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
    func displayData(viewModel: WeatherEnumModel.ViewModel.ViewModelData) {
        
        switch viewModel {

        case .displayWeather(let currentWeatherViewModel):
            weatherView.configure(viewModel: currentWeatherViewModel)
        }
    }
}

