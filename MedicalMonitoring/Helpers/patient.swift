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
    var other: [[String:String]] = []
    var size: String!
    var smoker: String!
    var vaccine: String!
    var vegetarian: String!
    var weight:Double!
    
    
    init(age: Int, allergies: String,athletic: String, bloodgroup:String, diabetic:String, diseases:String, ethnies:String, gender:String, job:String,name:String,
         other:[[String:String]], size:String, smoker:String, vaccine:String, vegetarian:String, weight:Double) {
        
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
    init() {
        self.age = 0
        self.allergies =  ""
        self.athletic =  ""
        self.bloodgroup = ""
        self.diabetic = ""
        self.diseases = ""
        self.ethnies = ""
        self.gender = ""
        self.job = ""
        self.name = ""
        self.other = []
        self.size = ""
        self.smoker = ""
        self.vaccine = ""
        self.vegetarian = ""
        self.weight = 0
    }
    
}
