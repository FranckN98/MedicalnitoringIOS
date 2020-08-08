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
    }
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
  
    @IBAction func login(_ sender: Any)
    {
        // TODO: Validate Fields
       /* let email = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let passwort = password.text!.trimmingCharacters(in: .whitespacesAndNewlines) */
      
        print(username.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        print(password.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        //Signing in the user
        Auth.auth().signIn(withEmail: username.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: password.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, error) in
            
            
            if(error != nil )
            {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else
            {
                Constants.userid = Auth.auth().currentUser?.uid
                self.username.text = ""
                self.password.text = ""
                self.performSegue(withIdentifier: "toMenu", sender: nil)
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toMenu"
        {
            _ = segue.destination as! MenuViewController
           
        }
    }
    
    
    @IBAction func passwordForgot(_ sender: Any)
    {
        
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
