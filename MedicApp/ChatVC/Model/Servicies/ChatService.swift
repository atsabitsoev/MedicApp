//
//  ChatService.swift
//  MedicApp
//
//  Created by Ацамаз Бицоев on 22/05/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

class ChatService {
    
    
    init() {
        
        socket = manager.defaultSocket
        
        addHandlers()
        socket.connect()
    }
    
    
    let manager = SocketManager(socketURL: URL(string: "https://socket-io-chat.now.sh")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    var name: String?
    var resetAck: SocketAckEmitter?
    
    
    private func addHandlers() {
        
        socket.on(clientEvent: .connect) { data, ack in
            
            print("Коннектед\n\n\n\n\n\n")
        }
        
        socket.on("new message") { (data, ack) in
            
            let json = JSON(data[0])
            print()
            print("\(json["username"]) написал :\"\(json["message"])\"")
            print()
        }
        
    }
    
    
}
