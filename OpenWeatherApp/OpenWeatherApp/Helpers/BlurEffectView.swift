//  BlurEffectView.swift
//  OpenWeatherApp
//
//  Created by Serhii Bets on 10/1/23.
//
import Foundation
import UIKit

class BlurEffect: UIVisualEffectView{
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: UIBlurEffect(style: .regular))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.opacity = 0.4
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
