//
//  DailyTableView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

import Foundation
import UIKit

class DailyTableView: UITableView, UITableViewDataSource, UITableViewDelegate{
    var cells: [CurrentWeatherViewModel.Daily]?
    
    static let cellHeight:CGFloat = 55
    
    //MARK: - init
    init() {
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        isScrollEnabled = false
        allowsSelection = false
        backgroundColor = .clear
        
        register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseId)
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cells = cells else { return 0}
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: DailyTableViewCell.reuseId, for: indexPath) as! DailyTableViewCell
        guard let cells = cells else { return cell}
        cell.set(data: cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DailyTableView.cellHeight
    }
    
    //MARK: - configure
    func set(cells: [CurrentWeatherViewModel.Daily]){
        self.cells = cells
        reloadData()
    }
}
