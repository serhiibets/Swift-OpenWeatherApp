//  WeatherView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import UIKit

class WeatherView: UIScrollView {
    //MARK: - Create UI components
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AssetsColor.primaryBackground.color
        view.alpha = 0
        return view
    }()
    
    // Loading View
    private lazy var loadingText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Завантаження..."
       return label
    }()
    
    private lazy var spiner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.style = .large
        spiner.color = .white
        spiner.translatesAutoresizingMaskIntoConstraints = false
        spiner.startAnimating()
        return spiner
    }()
    
    // Main view components
    private lazy var locationMarkerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "mappin.and.ellipse")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    
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
    
    private lazy var hourlyCollectionView = HourlyCollectionView()
    private lazy var dailyTableView = DailyTableView()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSelfScrollView()
        
        addSubview(loadingText)
        addSubview(spiner)
        addSubview(mainView)
        
        ///HeaderView
        mainView.addSubview(cloudBigImage)
        mainView.addSubview(tempIcon)
        mainView.addSubview(tempMinMaxLabel)
        mainView.addSubview(humidityIcon)
        mainView.addSubview(humidityLabel)
        mainView.addSubview(windIcon)
        mainView.addSubview(windLabel)
        
        ///Hourly weather CollectionView
        mainView.addSubview(hourlyCollectionView)
        
        ///Deily weather TableView
        mainView.addSubview(dailyTableView)

        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        let safeArea: CGFloat = 18
        let iconSize: CGFloat = 30
        
        //Loading
        loadingText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingText.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        loadingText.contentHuggingPriority(for: .vertical)

        spiner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spiner.topAnchor.constraint(equalTo: self.loadingText.bottomAnchor, constant: 30).isActive = true
        spiner.contentHuggingPriority(for: .vertical)
        
        // mainView constraints
        mainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        mainView.contentHuggingPriority(for: .vertical)
        
        cloudBigImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        cloudBigImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeArea).isActive = true
        cloudBigImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cloudBigImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        tempIcon.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30).isActive = true
        tempIcon.leadingAnchor.constraint(equalTo: cloudBigImage.trailingAnchor, constant: 20).isActive = true
        tempIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        tempIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        
        tempMinMaxLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30).isActive = true
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
    func configure (viewModel: CurrentWeatherViewModel){
        DispatchQueue.main.async {
            self.loadingText.alpha = 0
            UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: [.allowUserInteraction],
                           animations: { () -> Void in
                self.mainView.alpha = 1
                self.spiner.stopAnimating()
            })

            self.backgroundColor = self.mainView.backgroundColor
            self.inputViewController?.navigationItem.title = viewModel.locality
            self.tempMinMaxLabel.text = viewModel.maxMinTemp
            self.humidityLabel.text = viewModel.humidity
            self.windLabel.text = viewModel.wind
            
            self.hourlyCollectionView.set(cells: viewModel.hourlyWeather)
            self.dailyTableView.set(cells: viewModel.dailyWeather)

            
            
            
            self.hourlyCollectionView.frame = CGRect(x: -18,
                                                     y: self.cloudBigImage.frame.maxY + 10,
                                                     width: self.frame.width,
                                                     height: 165)
            
            self.dailyTableView.frame = CGRect(x: -18,
                                               y: self.hourlyCollectionView.frame.maxY,
                                               width: self.frame.width,
                                               height: DailyTableView.cellHeight * 7)
        }
    }
    
    func configureSelfScrollView(){
        self.bounces = false
        self.contentInsetAdjustmentBehavior = .never
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        backgroundColor = AssetsColor.primaryBackground.color
    }
}
