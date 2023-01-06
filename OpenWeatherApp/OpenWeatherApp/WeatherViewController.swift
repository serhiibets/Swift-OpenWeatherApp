//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 5/1/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    let weatherView = WeatherView()
    
    // MARK: - View lifecycle
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }
}

