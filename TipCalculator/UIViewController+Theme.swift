//
//  UIViewController+Theme.swift
//  TipCalculator
//
//  Created by Home on 3/8/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum TCTheme: String {
        case orange
        case white
        case blue
        case green
        
        static let allThemes = ["orange", "white", "blue", "green"]
        
        func getColor() -> UIColor {
            switch self {
            case .orange:
                return UIColor(red: 255/255, green: 204/255, blue: 51/255, alpha: 1)
            case .blue:
                return UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1)
            case .green:
                return UIColor(red: 204/255, green: 255/255, blue: 51/255, alpha: 1)
            default:
                return UIColor.white
            }
        }
    }
    
    
    func setTheme() {
        if let currentTheme = TipCalculatorCore.getCurrentTheme(), let theme = TCTheme(rawValue: currentTheme) {
            self.view.backgroundColor = theme.getColor()
        }
    }
    
}
