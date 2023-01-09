//  LoadingView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 9/1/23.
//
import UIKit

class LoadingView: UIView {
    //MARK: - Create UI components
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
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(loadingText)
        addSubview(spiner)
        
        self.backgroundColor = AssetsColor.primaryBackground.color
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        loadingText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingText.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        loadingText.contentHuggingPriority(for: .vertical)

        spiner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spiner.topAnchor.constraint(equalTo: self.loadingText.bottomAnchor, constant: 30).isActive = true
        spiner.contentHuggingPriority(for: .vertical)
    }
}
