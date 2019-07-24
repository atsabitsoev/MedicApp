//
//  Advice.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 23/07/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class Advice {
    
    init(type: AdviceType,
         name: String? = nil,
         text: String? = nil,
         imageUrls: [URL]? = nil,
         videoUrls: [URL]? = nil,
         videoPreviewUrls: [URL]?) {
        
        self.name = name
        self.type = type
        self.text = text
        self.imageUrls = imageUrls
        self.videoUrls = videoUrls
        self.videoPreviewUrls = videoPreviewUrls
    }
    
    var type: AdviceType
    var name: String?
    var text: String?
    var imageUrls: [URL]?
    var videoUrls: [URL]?
    var videoPreviewUrls: [URL]?
}
