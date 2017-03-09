//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Home on 3/6/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    private let themeKey = "theme"
    
    @IBOutlet weak var tipOne: UITextField!
    @IBOutlet weak var tipTwo: UITextField!
    @IBOutlet weak var tipThree: UITextField!
    @IBOutlet weak var billResetTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipOne.delegate = self
        tipTwo.delegate = self
        tipThree.delegate = self
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnClicked))
        navigationItem.setRightBarButton(saveBtn, animated: true)

        configureUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
    }
    
    private func configureUIElements() {
        let values = TipCalculatorCore.getTipPercentages()
        if values.count == 3 {
            tipOne.text = values.first
            tipTwo.text = values[1]
            tipThree.text = values.last
        }
        
        if let billResetValue = TipCalculatorCore.getBillResetTime() {
            billResetTime.text = billResetValue
        } else {
            //Insert default value of 10min
            TipCalculatorCore.insert(billResetTime: "10")
            billResetTime.text = "10"
        }
    }
    
    @objc private func saveBtnClicked() {
        
        var newTips = [String]()

        if let tipValueText = tipOne.text, let tipValue = Double(tipValueText), tipValue >= 0.0 && tipValue <= 100.0 {
            newTips.append(tipValueText)
        }

        if let tipValueText = tipTwo.text, let tipValue = Double(tipValueText), tipValue >= 0.0 && tipValue <= 100.0 {
            newTips.append(tipValueText)
        }

        if let tipValueText = tipThree.text, let tipValue = Double(tipValueText), tipValue >= 0.0 && tipValue <= 100.0 {
            newTips.append(tipValueText)
        }

        var billResetHasValue = false
        
        if let billResetValue = billResetTime.text, let billResetValueDouble = Double(billResetValue), billResetValueDouble >= 0 {
            TipCalculatorCore.insert(billResetTime: billResetValue)
            billResetHasValue = true
        }
        
        if newTips.count == 3 && billResetHasValue {
            TipCalculatorCore.insert(tips: newTips)
            presentAlertView(message: "Saved successfully")
        } else {
            if !billResetHasValue {
                presentAlertView(message: "Enter a valid bill reset time")
            } else {
                presentAlertView(message: "Tip percentages cannot be less than 0 and greater than 100")
            }
        }
        
    }
    
    private func presentAlertView(message: String) {
        let alert = UIAlertController(title: "Tip Calculator", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectThemeAction(_ sender: Any) {
        let themesList = TCTheme.allThemes
        let actionSheet = UIAlertController(title: "Tip Calculator", message: "Choose a Theme", preferredStyle: .actionSheet)
        for themeString in themesList {
            actionSheet.addAction(UIAlertAction(title: themeString, style: .default, handler: { [weak self] (action) in
                if let title = action.title {
                    TipCalculatorCore.insert(theme: title)
                    self?.setTheme()
                }
            }))
        }
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let _ = Double(string) else {
            if string == "" {
                return true
            }
            return false
        }
        
        return true
    }
}
