//
//  TipCalculatorCore.swift
//  TipCalculator
//
//  Created by Home on 3/6/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation


class TipCalculatorCore: NSObject {
    
    private static let defaults = UserDefaults.standard
    private static let tipPercentagesKey = "tipPercentages"

    static func getTipPercentages() -> [String] {
        
        if let tipPercentages = defaults.value(forKey: tipPercentagesKey) as? Array<String> {
            return tipPercentages
        } else {
            let defaultTipPercentages = ["18", "20", "25"]
            insert(tips: defaultTipPercentages)
            return defaultTipPercentages
        }
    }

    static func insert(tips: [String]) {
        let tipsArray = tips
        defaults.set(tipsArray, forKey: tipPercentagesKey)
        defaults.synchronize()
    }

}
