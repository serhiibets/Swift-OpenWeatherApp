//  HourlyCollectionView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//
import UIKit

class HourlyCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var cells: [CurrentWeatherViewModel.Hourly]?
    
    //MARK: - init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = AssetsColor.secondaryBackground.color
        
        register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CollectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cells = cells else { return 0 }
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.reuseId, for: indexPath) as! HourlyCollectionViewCell
        guard let cells = cells else { return cell}
        cell.configure(data: cells[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (bounds.size.width - 40) / 4
        let height: CGFloat = 145
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - configure
    func configure(cells: [CurrentWeatherViewModel.Hourly]){
        self.cells = cells
        reloadData()
    }
}
