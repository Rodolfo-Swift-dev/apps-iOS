//
//  InitialViewController.swift
//  SeaFood
//
//  Created by rodoolfo gonzalez on 14-06-23.
//

import UIKit



class InitialViewController : UIViewController {
    var yolo = YoloViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        yolo.startDetection()
        
    }
}
