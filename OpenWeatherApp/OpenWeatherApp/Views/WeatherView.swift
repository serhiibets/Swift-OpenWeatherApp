//
//  WeatherView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

import UIKit

class WeatherView: UIScrollView{
    private var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 1
        return view
    }()
    
    private var locationMarkerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "mappin.and.ellipse")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .right
        label.text = "Benidorm"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private var cloudBigImage: UIImageView = {
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
    
    private var tempMinMaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "+27° / +19°"
        label.textAlignment = .left
        return label
    }()
    
    private var dtIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "drop")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.tintColor = .white
        return image
    }()
    
    private var dtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "33 %"
        label.textAlignment = .left
        return label
    }()
    
    private var windIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
    private var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "10 м/cек"
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSelfScrollView()
        
        addSubview(mainView)
        mainView.addSubview(locationMarkerImage)
        mainView.addSubview(cityLabel)
        mainView.addSubview(cloudBigImage)
        mainView.addSubview(tempIcon)
        mainView.addSubview(tempMinMaxLabel)
        mainView.addSubview(dtIcon)
        mainView.addSubview(dtLabel)
        mainView.addSubview(windIcon)
        mainView.addSubview(windLabel)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelfScrollView(){
        self.bounces = false
        self.contentInsetAdjustmentBehavior = .never
        self.showsVerticalScrollIndicator = false
        backgroundColor = #colorLiteral(red: 0.2876678407, green: 0.5634036064, blue: 0.88738662, alpha: 1)
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        
        // mainView constraints
        mainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        mainView.contentHuggingPriority(for: .vertical)
        
        //locationMarkerImage constraints
        locationMarkerImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 100).isActive = true
        locationMarkerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        locationMarkerImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        locationMarkerImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        // cityLabel constraints
        cityLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 100).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: locationMarkerImage.trailingAnchor, constant: 10).isActive = true
        
        cloudBigImage.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20).isActive = true
        cloudBigImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        cloudBigImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cloudBigImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        tempIcon.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30).isActive = true
        tempIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        tempIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true

        tempMinMaxLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30).isActive = true
        tempMinMaxLabel.leadingAnchor.constraint(equalTo: tempIcon.trailingAnchor, constant: 10).isActive = true
        tempMinMaxLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
        
        dtIcon.topAnchor.constraint(equalTo: tempIcon.bottomAnchor, constant: 15).isActive = true
        dtIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        dtIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dtIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dtLabel.topAnchor.constraint(equalTo: tempMinMaxLabel.bottomAnchor, constant: 15).isActive = true
        dtLabel.leadingAnchor.constraint(equalTo: dtIcon.trailingAnchor, constant: 10).isActive = true
        dtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
        
        windIcon.topAnchor.constraint(equalTo: dtIcon.bottomAnchor, constant: 15).isActive = true
        windIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        windIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        windLabel.topAnchor.constraint(equalTo: dtLabel.bottomAnchor, constant: 15).isActive = true
        windLabel.leadingAnchor.constraint(equalTo: windIcon.trailingAnchor, constant: 10).isActive = true
        windLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
    }
}
