//
//  AppStyle.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 8/1/23.
//

import UIKit

enum AssetsColor {
    case primaryBackground
    case secondaryBackground
    case whiteBackground
    
    var color: UIColor {
        switch self {
            case .primaryBackground   : return UIColor(named: "AppStylePrimaryBackgroundColor")!
            case .secondaryBackground : return UIColor(named: "AppStyleSecondaryBackgroundColor")!
            case .whiteBackground     : return UIColor.white
        }
    }
}
