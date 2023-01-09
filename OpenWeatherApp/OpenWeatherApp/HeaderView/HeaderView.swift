//  HeaderView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 9/1/23.
//
import UIKit

class HeaderView: UIView {
    //MARK: - UI view components
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .right
        label.text = "-"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var cloudBigImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private var tempIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "thermometer.sun")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.tintColor = .white
        return image
    }()
    
    private lazy var tempMinMaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "- / -"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var humidityIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "drop")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.tintColor = .white
        return image
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "- %"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var windIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "- м/cек"
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cloudBigImage)
        addSubview(tempIcon)
        addSubview(tempMinMaxLabel)
        addSubview(humidityIcon)
        addSubview(humidityLabel)
        addSubview(windIcon)
        addSubview(windLabel)
        self.backgroundColor = AssetsColor.primaryBackground.color
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        let safeArea: CGFloat = 18
        let iconSize: CGFloat = 30
        
        cloudBigImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cloudBigImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeArea).isActive = true
        cloudBigImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cloudBigImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        tempIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        tempIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        tempIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        tempIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        tempMinMaxLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        tempMinMaxLabel.leadingAnchor.constraint(equalTo: tempIcon.trailingAnchor, constant: 10).isActive = true
        tempMinMaxLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeArea).isActive = true
        
        humidityIcon.topAnchor.constraint(equalTo: tempIcon.bottomAnchor, constant: 15).isActive = true
        humidityIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        humidityIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        humidityIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        humidityLabel.topAnchor.constraint(equalTo: tempMinMaxLabel.bottomAnchor, constant: 15).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: humidityIcon.trailingAnchor, constant: 10).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeArea).isActive = true
        
        windIcon.topAnchor.constraint(equalTo: humidityIcon.bottomAnchor, constant: 15).isActive = true
        windIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        windIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        windLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 15).isActive = true
        windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 10).isActive = true
        windLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeArea).isActive = true
    }
    
    //MARK: - configure
    func configure(viewModel: CurrentWeatherViewModel){
        self.tempMinMaxLabel.text = viewModel.maxMinTemp
        self.humidityLabel.text = viewModel.humidity
        self.windLabel.text = viewModel.wind
    }
}
