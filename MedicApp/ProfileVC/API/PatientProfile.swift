//
//  PatientProfile.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 06/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class PatientProfile {
    
  var id: String
  var role: String
  var created: Int
  var name: String
  var surname: String
  var sex: String
  var growth: Float
  var weight: Float
  var age: Int
  var sport: Bool
  var workType: String
    
    init(id: String,
         role: String,
         created: Int,
         name: String,
         surname: String,
         sex: String,
         growth: Float,
         weight: Float,
         age: Int,
         sport: Bool,
         workType: String) {
        
        self.id = id
        self.role = role
        self.created = created
        self.name = name
        self.surname = surname
        self.sex = sex
        self.growth = growth
        self.weight = weight
        self.age = age
        self.sport = sport
        self.workType = workType
    }
}

enum Sex: String {
    
    case male = "male"
    case female = "female"
}

enum WorkType: String {
    
    case active = "active"
    case sedentary = "sedentary"
}
