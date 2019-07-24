//
//  Excercise.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 17/06/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class Exercise {
    
    var name: String
    var preview: URL
    var video: URL
    var category: String
    
    
    init(name: String,
         preview: URL,
         video: URL,
         category: String) {
        
        self.name = name
        self.preview = preview
        self.video = video
        self.category = category
    }
}
