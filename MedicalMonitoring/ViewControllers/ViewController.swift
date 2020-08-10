//
//  ViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 20.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var signin: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Constants.setupButton(button: signup)
        Constants.setupButton(button: signin)
    }


}

