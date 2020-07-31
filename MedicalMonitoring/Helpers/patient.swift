//
//  FloatingButton.swift
//  MedicalMonitoring
//
//  Created by ema on 30.07.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit

class patient
{
    var age : Int!
    var allergies : String!
    var athletic : String!
    var bloodgroup: String!
    var diabetic: String!
    var diseases: String!
    var ethnies: String!
    var gender: String!
    var id: String!
    var job: String!
    var name: String!
    var other: [[String:String]]
    var size: Int!
    var smoker: String!
    var vaccine: String!
    var vegetarian: String!
    var weight:Int!
    //hjghjghghghghghghghg
    
    init(age: Int, allergies: String,athletic: String, bloodgroup:String, diabetic:String, diseases:String, ethnies:String, gender:String, job:String,name:String,
         other:[[String:String]], size:Int, smoker:String, vaccine:String, vegetarian:String, weight:Int) {
        
        self.age = age
        self.allergies = allergies
        self.athletic = athletic
        self.bloodgroup = bloodgroup
        self.diabetic = diabetic
        self.diseases = diseases
        self.ethnies = ethnies
        self.gender = gender
        self.job = job
        self.name = name
        self.other = other
        self.size = size
        self.smoker = smoker
        self.vaccine = vaccine
        self.vegetarian = vegetarian
        self.weight = weight
    }
    
    
}
