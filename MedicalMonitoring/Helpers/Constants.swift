//
//  File.swift
//  MedicalMonitoring
//
//  Created by ema on 22.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import Foundation


struct Constants {

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
}
