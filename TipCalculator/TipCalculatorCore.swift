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
    private static let billKey = "bill"
    private static let billDateKey = "billDate"
    private static let billResetTimeKey = "billResetTime"
    private static let themeKey = "theme"

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

    static func insert(bill: String) {
        defaults.set(bill, forKey: billKey)
        defaults.set(Date(), forKey: billDateKey)
    }
    
    static func insert(billResetTime: String) {
        defaults.set(billResetTime, forKey: billResetTimeKey)
    }

    static func insert(theme: String) {
        defaults.set(theme, forKey: themeKey)
    }
    
    static func resetBill() {
        defaults.removeObject(forKey: billKey)
        defaults.removeObject(forKey: billDateKey)
    }

    static func getBillInsertDate() -> Date? {
        return defaults.value(forKey: billDateKey) as? Date
    }
    
    static func getBillAmount() -> String? {
        return defaults.value(forKey: billKey) as? String
    }
    
    static func getBillResetTime() -> String? {
        return defaults.value(forKey: billResetTimeKey) as? String
    }
    
    static func getCurrentTheme() -> String? {
        if let theme = defaults.value(forKey: themeKey) as? String {
            return theme
        } else {
            defaults.set("white", forKey: themeKey)
            defaults.synchronize()
            return "white"
        }
    }
}
