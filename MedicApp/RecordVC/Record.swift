//
//  Record.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 23/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class Record {
    
    
    var name: String
    var lastName: String
    var fathersName: String
    
    var phoneOrEmail: String
    var date: Date?
    
    init(name: String,
         lastName: String,
         fathersName: String,
         phoneOrEmail: String,
         date: Date?) {
        
        self.name = name
        self.lastName = lastName
        self.fathersName = fathersName
        self.phoneOrEmail = phoneOrEmail
        self.date = date
        
    }
}
