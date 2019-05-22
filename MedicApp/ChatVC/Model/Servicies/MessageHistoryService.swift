//
//  MessageHistoryService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


class MessageHistoryService {
    
    
    static var messages: [Message] = []
    
    
    static func fetchMessages() {
        
        let messageArr: [Message] = [Message(text: "Привет!", sender: .penPal, time: Date(), contentType: .text),
                                     Message(text: "И тебе привет доктор!", sender: .user, time: Date(), contentType: .text),
                                     Message(text: "fsd", sender:  .penPal, time: Date(), contentType: .photo, image: UIImage(named: "Вход"))]
        
        messages = messageArr
        NotificationManager.post(.messagesFetched)
    }
}
