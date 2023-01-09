//  HourlyCollectionViewCell.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import Foundation
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell{
    static let reuseId = "HourlyCollectionViewCell"
    
    //MARK: - Create UI components
    private lazy var howerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tempLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    // Constraints
    private func makeConstraints(){
        // howerLabel constraints
        howerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        howerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // weatherImage constraints
        weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        // tempLabel constraints
        tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AssetsColor.secondaryBackground.color

        contentView.addSubview(howerLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(tempLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Configure
    func set(data: CurrentWeatherViewModel.Hourly){
        howerLabel.text = data.dt
        weatherImage.image = UIImage(named: data.icon)
        tempLabel.text = data.temp
    }
}
