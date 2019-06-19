//
//  MessageHistoryService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit


class MessageHistoryService {
    
    
    private init() {}
    static let standard = MessageHistoryService()
    
    
    static var messages: [Message] = []
    
    
    static func fetchMessages() {
        
        let messageArr: [Message] = [Message(text: "Здравствуйте, что вас беспокоит?", sender: .penPal, time: Date(), contentType: .text)]
        
        messages = messageArr
        NotificationManager.post(.messagesFetched)
    }
}
