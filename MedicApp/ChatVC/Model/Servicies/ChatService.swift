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
    
    var lastMessage: Message? {
        didSet {
            NotificationManager.post(.newMessage)
        }
    }
    
    
    func startConnection() {
        
        socket = manager.defaultSocket
        
        addHandlers()
        socket.connect()
    }
    
    
    private let manager = SocketManager(socketURL: URL(string: "https://socket-io-chat.now.sh")!, config: [.log(true), .compress])
    private var socket: SocketIOClient!
    private var name: String?
    private var resetAck: SocketAckEmitter?
    
    
    private func addHandlers() {
        
        socket.on(clientEvent: .connect) { data, ack in
            
            print("Коннектед\n\n\n\n\n\n")
            
            self.socket.emit("add user", "Atsamazus") {
                print("\n\n\n\n\n\n\n\nlfskjdslkfjdslkfjdslk\n\n\n\n\n")
            }
            
        }
        
        socket.on("new message") { (data, ack) in
            
            let json = JSON(data[0])
            let userName = json["username"].stringValue
            let message = json["message"].stringValue
            let newMessage = Message(text: message, sender: .penPal, time: Date(), contentType: .text)
            self.lastMessage = newMessage
            MessageHistoryService.messages.append(newMessage)
        }
        
    }
    
    
    func sendMessage(_ message: Message) {
        
        socket.emit("new message", message.text) {
            print("отправлено")
        }
    }
    
    
    func stopConnection() {
        
        socket.disconnect()
        socket.off(clientEvent: .connect)
        socket.off("newMessage")
    }
    
    
}
