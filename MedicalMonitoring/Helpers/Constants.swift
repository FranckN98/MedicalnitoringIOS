//
//  File.swift
//  MedicalMonitoring
//
//  Created by ema on 22.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit


struct Constants {

    static let coolBlue = UIColor(red: 42/255, green: 126/255, blue: 230/255, alpha: 1.0)
    static var userid : String!
    static var addedValue : [[String:String]] = []
    static var patientbeforeEdit = ["age": 0,
    "allergies":  "" ,
    "athletic":  "",
    "bloodgroup": "",
    "diabetic": "",
    "diseases":  "",
    "ethnies": "",
    "gender": "",
    "id":Constants.userid ?? "",
    "job": "",
    "name":  "",
    "other":[],
    "size": 0,
    "smoker": "",
    "vaccine": "",
    "vegetarian": "",
    "weight": 0] as [String : Any]
    
    struct Storyboard
    {
      static let menuViewController = "MenuVC"
      static let editViewController = "editVC"
      static let infoViewController = "infoVC"
    }
    
    static func setupButton(button:UIButton)
    {
        setShadow(button: button)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor      = coolBlue
        button.layer.cornerRadius   = 5
        button.layer.borderWidth    = 1.5
        button.layer.borderColor    = UIColor.darkGray.cgColor
    }
       
       
    static func setShadow(button:UIButton)
   {
       button.layer.shadowColor   = UIColor.black.cgColor
       button.layer.shadowOffset  = CGSize(width: 0.0, height: 3.0)
       button.layer.shadowRadius  = 2
       button.layer.shadowOpacity = 0.5
       button.clipsToBounds       = true
       button.layer.masksToBounds = false
   }
       
       
   static func setupFloatButton(button:UIButton)
   {
    setShadow(button: button)
    button.layer.borderWidth    = 6
    button.backgroundColor      = .white
    button.layer.borderColor    = coolBlue.cgColor
   }
}
