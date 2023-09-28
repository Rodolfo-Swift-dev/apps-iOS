//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [ "Soft" : 3, "Medium" : 5, "Hard" : 8 ]
    var counter = 0
    var timer = Timer()
    var nivelCook : String = ""
    var player : AVAudioPlayer!
    
    @IBOutlet weak var eggLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        if let hardness = sender.currentTitle{
            nivelCook = hardness
        }
        counter = 1
        eggLabel.text = "Faltan \(eggTimes[nivelCook]! - (counter - 1))"
        
        progressBar.progress = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    @objc func updateCounter() {
        progress()
        //example functionality
        if counter  != eggTimes[nivelCook] {
            eggLabel.text = "Faltan \(eggTimes[nivelCook]! - counter)"
            print("\(counter) seconds")
            counter += 1
        }else{
            timer.invalidate()
            progressBar.progress = 1
            eggLabel.text = "DONE EGGS \(nivelCook)"
            playSound()
        }
        
            
        
    }
    func progress(){
        
            var  percent = Float(counter) / Float(eggTimes[nivelCook]!)
        progressBar.progress = percent
        
    }
}
