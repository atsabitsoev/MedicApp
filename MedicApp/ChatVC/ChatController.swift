//
//  ChatController.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation


class ChatController {
    
    
    private var view: ChatVC?
    private var model: ChatModel?
    
    init(view: ChatVC) {
        self.view = view
        self.model = ChatModel()
    }
    
    
    func fetchMessages() -> [Message] {
        
        return model!.fetchMessages()
    }
    
    
}
