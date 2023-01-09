//  WeatherView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import UIKit

class MainScrollView: UIScrollView {
    private lazy var loadingView = LoadingView()
    private lazy var headerView = HeaderView()
    private lazy var hourlyCollectionView = HourlyCollectionView()
    private lazy var dailyTableView = DailyTableView()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Loading screen
        self.loadingView.alpha = 1
        self.headerView.alpha = 0
        self.hourlyCollectionView.alpha = 0
        self.dailyTableView.alpha = 0
        
        addSubview(loadingView)
        addSubview(headerView)
        addSubview(hourlyCollectionView)
        addSubview(dailyTableView)

        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        let scrollContentGuide = contentLayoutGuide
        let scrollFrameGuide = frameLayoutGuide
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: scrollFrameGuide.bottomAnchor).isActive = true
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        hourlyCollectionView.heightAnchor.constraint(equalToConstant: 165).isActive = true
        hourlyCollectionView.widthAnchor.constraint(equalTo: scrollFrameGuide.widthAnchor).isActive = true

        dailyTableView.translatesAutoresizingMaskIntoConstraints = false
        dailyTableView.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor).isActive = true
        dailyTableView.widthAnchor.constraint(equalTo: scrollFrameGuide.widthAnchor).isActive = true
        dailyTableView.heightAnchor.constraint(equalTo: scrollFrameGuide.heightAnchor).isActive = true
    }
    
    //MARK: - configure
    func configure(viewModel: CurrentWeatherViewModel){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: [.allowUserInteraction],
                           animations: { () -> Void in
                
                //Hide loading screen, show main screen
                self.loadingView.alpha = 0
                self.headerView.alpha = 1
                self.hourlyCollectionView.alpha = 1
                self.dailyTableView.alpha = 1
            })

            self.headerView.configure(viewModel: viewModel)
            self.hourlyCollectionView.configure(cells: viewModel.hourlyWeather)
            self.dailyTableView.set(cells: viewModel.dailyWeather)
        }
    }
}
