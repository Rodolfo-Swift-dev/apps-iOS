//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let ballArray = [#imageLiteral(resourceName: "ball2"), #imageLiteral(resourceName: "ball1"), #imageLiteral(resourceName: "ball5"), #imageLiteral(resourceName: "ball3"), #imageLiteral(resourceName: "ball4")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeFirstResponder()
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
    };override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            ballImageView1.image = ballArray.randomElement()
        }
    }
    
    @IBOutlet weak var ballImageView1: UIImageView!
    
   
   
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        ballImageView1.image = ballArray.randomElement()
    }
   

}

