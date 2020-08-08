//
//  MenuViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 21.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuViewController: UIViewController {
    
    var userId : String!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var consultButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var observButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    // Log out Method
    @objc func logOutTapped()
    {
        do {
            try
                Auth.auth().signOut()
            print("Effect")
            Constants.userid = "" 
            _ = navigationController?.popToRootViewController(animated: true)
            
        }
        catch{
            print("Fault")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoButton.layer.cornerRadius = 25
        chatButton.layer.cornerRadius = 25
        consultButton.layer.cornerRadius = 25
        historyButton.layer.cornerRadius = 25
        observButton.layer.cornerRadius = 25
        testButton.layer.cornerRadius = 25
        userId = Auth.auth().currentUser?.uid
        Constants.userid = userId
        
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(logOutTapped))
        self.navigationItem.rightBarButtonItem = logoutButton

    }
    
    

}
