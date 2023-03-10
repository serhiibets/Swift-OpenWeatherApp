//  DailyTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import Foundation
import UIKit

class DailyTableViewCell: UITableViewCell{
    static let reuseId = "DailyTableViewCell"
    
    //MARK: - Create UI components
    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "09d")
        return view
    }()
    
    private lazy var tempMinMaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    //MARK: - Constraints
    private func makeConstraints(){
        dayOfWeekLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dayOfWeekLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        dayOfWeekLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        dayOfWeekLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        tempMinMaxLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tempMinMaxLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tempMinMaxLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AssetsColor.whiteBackground.color

        contentView.addSubview(dayOfWeekLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(tempMinMaxLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configure
    func configure(data: CurrentWeatherViewModel.Daily){
        dayOfWeekLabel.text = String(data.dt)
        weatherImage.image = UIImage(named: data.icon)
        tempMinMaxLabel.text = "\(data.minTemp) / \(data.maxTemp)"
    }
}
