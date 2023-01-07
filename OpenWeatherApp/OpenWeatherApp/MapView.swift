//
//  MapView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 7/1/23.
//

import UIKit
import MapKit

class MapView: UIScrollView {
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2876678407, green: 0.5634036064, blue: 0.88738662, alpha: 1)
        return view
    }()
    
    private var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private var mapView : MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(mainView)

        mainView.addSubview(searchBar)
        mainView.addSubview(mapView)

        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        mapView.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 50).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    //MARK: - configure
    func configure (viewModel: CurrentWeatherViewModel){
        DispatchQueue.main.async {
            self.backgroundColor = self.mainView.backgroundColor

            self.mapView.frame = CGRect(x: 0,
                                        y: 0,
                                        width: self.frame.width,
                                        height: self.frame.height)
        }
    }
}
