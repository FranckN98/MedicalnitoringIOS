//
//  File.swift
//  MedicalMonitoring
//
//  Created by ema on 04.08.20.
//  Copyright © 2020 ema. All rights reserved.
//

import UIKit


class Visit
{
    var title: String!
    var temperature: Int!
    var startTime: String!
    var endTime:String!
    var prescription:String!
    var other : [[String:String]]
    
    init() {
        title = ""
        temperature = 0
        startTime = ""
        endTime = ""
        prescription = ""
        other = []
    }
    init(title:String, temperature:Int, startTime:String, endTime:String, prescription:String, other : [[String:String]]) {
        self.title = title
        self.temperature = temperature
        self.startTime = startTime
        self.endTime = endTime
        self.prescription = prescription
        self.other = other
    }
}
