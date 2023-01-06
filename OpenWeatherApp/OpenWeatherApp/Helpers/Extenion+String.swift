//
//  Extenion+String.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 6/1/23.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

}
