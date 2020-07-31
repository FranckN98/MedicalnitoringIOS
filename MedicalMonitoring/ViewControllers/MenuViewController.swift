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
        print(Constants.userid!)
        
        // Do any additional setup after loading the view.
    }
    
    //@IBOutlet weak var collectionView: UICollectionView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
