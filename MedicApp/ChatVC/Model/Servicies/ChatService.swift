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
    
    private var dialogId: String?
    
    
    func startConnection() {
        
        socket = manager.defaultSocket
        
        addHandlers()
        socket.connect()
    }
    
    
    private let manager = SocketManager(socketURL: URL(string: ApiInfo().baseUrl)!,
                                        config: [.secure(false),
                                                 .path("/socstream"),
                                                 .log(false)])
    private var socket: SocketIOClient!
    private var name: String?
    private var resetAck: SocketAckEmitter?
    
    
    private func addHandlers() {
        
        
        socket.on(clientEvent: .connect) { data, ack in
            
            self.connected = true
            print("connect")
            
            
            self.socket.emit("auth",
                             ["userId" : "\(TokenService.standard.id!)", "token" : "\(TokenService.standard.token!)"],
                             completion: {
                                
                                print("authEmited")
            })
            
        }
        
        socket.on("authOk") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
            
            let dialogsArr = json["dialogs"].arrayValue
            
            guard dialogsArr.count != 0 else {
                print("Нет доступных диалогов")
                return
            }
            
            let dialogId = dialogsArr.first!["id"].stringValue
            print("dialog id - \(dialogId)")
            
            self.dialogId = dialogId
        }
        
        socket.on("enteredDialog") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
            
            let messagesJSON = json["messages"].arrayValue.dropLast(json["messages"].count - 30)
            let messages = self.parseMessagesFromJSON(messagesJSON: [JSON](messagesJSON))
            
            MessageHistoryService.standard.messages = messages.reversed()
            NotificationManager.post(.messagesFetched)
        }
        
        socket.on("messageReceive") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
            
            let messageJSON = json["message"]
            
            guard messageJSON["author"].stringValue != TokenService.standard.id! else { return }
            
            let contentType = messageJSON["type"].string
            var messageText = ""
            var image: UIImage?
            
            switch contentType {
            case MessageContentType.text.rawValue:
                
                messageText = messageJSON["message"].stringValue
                
            case MessageContentType.photo.rawValue:
                
                let imageUrl = messageJSON["message"].stringValue
                guard let imageData = try? Data(contentsOf: URL(string: "\(ApiInfo().baseUrl)\(imageUrl)")!) else { return }
                image = UIImage(data: imageData)
                
            default:
                
                print("error")
                
            }
            
            self.lastMessage = Message(text: messageText, sender: .penPal, time: Date(), contentType: .text, image: image)
        }
        
        socket.on("leavedDialog") { (data, ack) in
            
            print("Вышел из чата")
        }
        
        socket.on("newMessage") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
            
            NotificationManager.post(.messageFromSomewhere)
        }
        
        socket.on("messageListReceive") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
        }
        
        socket.on("error-pipe") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
        }
        
        socket.on("messageListReceive") { (data, ack) in
            
            let json = JSON(data[0])
            print(json)
            
            if json["messages"].arrayValue.count >= 30 {
                let jsonMessages = json["messages"].arrayValue
                let receivedMessages = self.parseMessagesFromJSON(messagesJSON: jsonMessages)
                MessageHistoryService.standard.messages = receivedMessages.reversed() + MessageHistoryService.standard.messages
            }
            
            NotificationManager.post(.messagesFetched)
        }
        
        
    }
    
    
    func sendMessage(_ message: Message) {
        
        var messageText = ""
        var type = ""
        
        switch message.contentType {
            
        case .text:
            
            messageText = message.text
            type = "text"
            
        case .photo:
            
            let image = message.image
            let imageData = image?.pngData()
            let imageBase64 = imageData!.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
            print(imageBase64)
            messageText = "data:image/png;base64,\(imageBase64)"
            type = "photo"
            
        }
        
        socket.emit("message", ["message": messageText,
                                "type": type]) {
            print("отправлено")
        }
        
        print(["message": message.text])
    }
    
    
    func loadMoreMessages() {
        
        socket.emit("getMessageList", ["skip": MessageHistoryService.standard.messages.count,
                                       "limit": 30])
    }
    
    
    private func parseMessagesFromJSON(messagesJSON: [JSON]) -> [Message] {
        
        let messages = messagesJSON.map({ (json) -> Message in
            
            var image: UIImage?
            if let url = URL(string: "\(ApiInfo().baseUrl)\(json["message"])"),
                let imageData = try? Data(contentsOf: url) {
                
                image = UIImage(data: imageData)
            }
            
            let message = Message(text: json["message"].string ?? "",
                                  sender: json["author"].stringValue == TokenService.standard.id! ? .user : .penPal,
                                  time: Date(timeIntervalSince1970: json["date"].doubleValue / 1000),
                                  contentType: MessageContentType(rawValue: json["type"].stringValue) ?? .text,
                                  image: image)
            return message
        })
        
        return messages
    }
    
    
    func enterChat() {
        self.socket.emit("enterInDialog", ["dialogId" : dialogId],
                         completion: {
                            print("enterInDialogEmited")
        })
    }
    
    func exitFromChat() {
        
        socket.emit("exitFromChat")
    }
    
    
    func stopConnection() {
        
        socket.disconnect()
        socket.off(clientEvent: .connect)
        socket.off("authOk")
        socket.off("enteredDialog")
        socket.off("messageReceive")
        socket.off("leavedDialog")
        socket.off("newMessage")
        socket.off("messageListReceive")
        socket.off("newMessage")
        socket.off("error-pipe")
    }

}
