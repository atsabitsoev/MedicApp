//
//  SaveManager.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 20/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation

class SaveManager {
    
    static func save(value: Any, key: UserDefaultsKeys) {
        
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
