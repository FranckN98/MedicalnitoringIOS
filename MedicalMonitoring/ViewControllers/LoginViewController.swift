//
//  LoginViewController.swift
//  MedicalMonitoring
//
//  Created by ema on 20.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
  
    @IBAction func login(_ sender: Any)
    {
        // TODO: Validate Fields
        let email = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let passwort = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: passwort) { (result, error) in
            
            
            if(error != nil)
            {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else
            {
                let homeViewController = self.storyboard?.instantiateViewController(identifier:Constants.Storyboard.menuViewController) as? MenuViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
    
    @IBAction func passwordForgot(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
