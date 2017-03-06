//
//  ViewController.swift
//  TipCalculator
//
//  Created by Rohit on 3/5/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billValue.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billValue.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: UITextField) {
        configureValues()
    }
    
    @IBAction func tipValueChanged(_ sender: UISegmentedControl) {
        configureValues()
    }
    
    private func configureValues() {
        var billAmount: Double = 0
        var tipPercentage: Double = 0
        
        switch tipControl.selectedSegmentIndex {
        case 1:
            tipPercentage = 0.2
        case 2:
            tipPercentage = 0.25
        default:
            tipPercentage = 0.18
        }
        
        if let amount = billValue.text, let amountInDouble = Double(amount) {
           billAmount = amountInDouble
        }
        
        let tipAmount = billAmount * tipPercentage
        
        tipValue.text = "$\(tipAmount)"
        totalValue.text = "$\(billAmount + tipAmount)"
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
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
