//
//  RegistrationViewController.swift
//  
//
//  Created by ema on 20.07.20.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class RegistrationViewController: UIViewController
{

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var firstnameTxtfield: UITextField!
    @IBOutlet weak var lastnameTxtfield: UITextField!
    @IBOutlet weak var emailTxtfield: UITextField!
    @IBOutlet weak var passwordTxtfield: UITextField!
    @IBOutlet weak var ageTxtfield: UITextField!
    @IBOutlet weak var patientOrDoctor: UISegmentedControl!
    var doctor : Bool = false;
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            doctor = false;
        }
        else
        {
            doctor = true;
        }
        
    }
    // check the fields and validate the data is correct. If everything is correct, this method returns nil, Otherwise, it returns the error message
    func validateFields() ->String?
    {
        //Check that all fields are filled in
        
        if firstnameTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnameTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ageTxtfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        
        {
            return "Please fill in all Fields."
        }
        return nil
    }
    
    func showError(_ message:String)
    {
           errorLabel.text = message
           errorLabel.alpha = 1
    }
    
    @IBAction func signUp(_ sender: Any)
    {
        //Validate the fields
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
        else
        {
            
            let firstName = firstnameTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines
            )
            let lastName = lastnameTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let age = ageTxtfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                if err != nil
                {
                    self.showError("Error creating 1user")
                }
                else
                {
                    // User was created successfully now store the first name and last name
                    var ref: DatabaseReference!

                    ref = Database.database().reference()
                    
                    let postObject = [
                        "id": result!.user.uid,
                        "firstName" : firstName,
                        "lastName" : lastName,
                        "email" : email,
                        "password" : password,
                        "age" : age
                    ]
                    
                    if(self.doctor)
                    {
                        let postref =  ref.child("DoctorList").childByAutoId()
                        postref.setValue(postObject, withCompletionBlock: {
                            error, ref in
                            if error == nil
                            {
                                self.dismiss(animated: true, completion: nil)
                            }
                            else
                            {
                                // handle execption
                            }
                        })
                        
                    }
                    else
                    {
                        let postref =  ref.child("UserList").childByAutoId()
                        postref.setValue(postObject, withCompletionBlock: {
                            error, ref in
                            if error == nil
                            {
                                self.dismiss(animated: true, completion: nil)
                            }
                            else
                            {
                                // handle exception
                            }
                        })
                    }
                    // Transition to the Menu Screen
                    self.transitionToMenu()
                    
                   
                }
            // Transition to the home screen
        }
        }
    }
    
    func transitionToMenu()
    {
        let homeViewController = storyboard?.instantiateViewController(identifier:Constants.Storyboard.menuViewController) as? MenuViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

