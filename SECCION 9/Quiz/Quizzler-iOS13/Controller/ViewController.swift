//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var quizBrain = QuizBrain()
   
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Do any additional setup after loading the view.
    }

  
    @IBAction func answerButtonPressed(_ sender: UIButton) {
    
        timer.invalidate()
        let userAnswer = sender.currentTitle!
        let resultAnswer = quizBrain.checkAnswer(answer: userAnswer)
         
        
        if resultAnswer{
            sender.backgroundColor = UIColor.green
        }else{
            sender.backgroundColor = UIColor.red
        }
       
    
        quizBrain.updateQestion()
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
        
       
        
    }
  
    @objc func updateUI(){
        
        progressBar.progress = quizBrain.progress()
        questionLabel.text =  quizBrain.getQuestionText()
        scoreLabel.text = "SCORE : \(quizBrain.getScore())"
        
        button1.setTitle(quizBrain.altA, for: .normal)
        button2.setTitle(quizBrain.altB, for: .normal)
        button3.setTitle(quizBrain.altC, for: .normal)
        button1.backgroundColor = UIColor.clear
        button2.backgroundColor = UIColor.clear
        button3.backgroundColor = UIColor.clear
        
    }
   
    
}

