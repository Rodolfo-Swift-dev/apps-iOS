//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by rodoolfo gonzalez on 27-04-23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var percent : Double = 0.0
    var persons : Int = 1
    var resultText : String = ""
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = resultText
        settingsLabel.text = "Split between \(persons) people, with \(percent * 100) tip."

        // Do any additional setup after loading the view.
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
