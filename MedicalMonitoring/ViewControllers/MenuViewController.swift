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
    @IBAction func logOutTapped(_ sender: Any)
    {
        do {
            try Auth.auth().signOut()
            Constants.userid = "" 
            dismiss(animated: true, completion: nil)
            
        }
        catch{
            
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
      //  print(Constants.userid!)
        
        // Do any additional setup after loading the view.
    }
    
    

}
