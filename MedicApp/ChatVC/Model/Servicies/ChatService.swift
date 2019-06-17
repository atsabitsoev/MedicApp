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
    
    private init() {
        print("создал")
        startConnection()
    }
    static let standard = ChatService()
    
    
    private var connected = false
    
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
    
    
    private let manager = SocketManager(socketURL: URL(string: "\(ApiInfo().baseUrl)")!, config: [.secure(false), .path("/socstream"), .log(true)])
    private var socket: SocketIOClient!
    private var name: String?
    private var resetAck: SocketAckEmitter?
    
    
    private func addHandlers() {
        
        
        socket.on(clientEvent: .connect) { data, ack in
            
            self.connected = true
            print("connect")
            
            self.socket.emit("authOk",
                             ["token : \(TokenService.standard.token!), id : \(TokenService.standard.id!)"],
                             completion: {
                                
                                print("emit")
            })
            
        }
        
        socket.on("auth") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
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
