//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    var percent : Double = 0.0
    var persons : Int = 1
    var resultText : String = ""
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentypctButton: UIButton!

    @IBOutlet weak var splitNumberLabel: UILabel!
    

    
    @IBAction func tipChanged(_ sender: UIButton) {
        if sender.tag == 0{
            sender.isSelected = true
            tenPctButton.isSelected = false
            twentypctButton.isSelected = false
            percent = 0
        }else if sender.tag == 1{
            zeroPctButton.isSelected = false
            sender.isSelected = true
            twentypctButton.isSelected = false
            percent = 0.1
        }else if sender.tag == 2{
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            sender.isSelected = true
            percent = 0.2
        }
        print(percent)
        billTextField.endEditing(true)
    }
    @IBAction func steppervaluechanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        persons = Int(sender.value)
    }
    @IBAction func calculatedPressed(_ sender: UIButton) {
        if let totalText = billTextField.text{
            if let total = Double(totalText){
                let result = (total * (1.0 + percent)) / Double(persons)
                resultText = String(format: "%.2f", result)
            }
        }
        
        performSegue(withIdentifier: "goToBMI", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBMI" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.percent = percent
            destinationVC.persons = persons
            destinationVC.resultText = resultText
            
        }
    }

    

}

