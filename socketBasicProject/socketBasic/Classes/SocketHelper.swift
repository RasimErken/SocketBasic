//
//  SocketHelper.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import UIKit
import Foundation
import SocketIO
import Combine


let kHost = "http://192.168.1.34:3001"
let kConnectUser = "connectUser"
let kUserList = "userList"
let kExitUser = "exitUser"


final class SocketHelper: NSObject {
    
    static let shared = SocketHelper()
    
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    override init() {
        super.init()
        configureSocketClient()
    }
    
    private func configureSocketClient() {
        
        guard let url = URL(string: kHost) else {
            return
        }
        
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        
        
        guard let manager = manager else {
            return
        }
        
        socket = manager.socket(forNamespace: "/**********")
    }
    
    func establishConnection() {
        
        
        
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.connect()
    }
    
    func closeConnection() {
        
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.disconnect()
    }
    
    func joinChatRoom(nickname: String, completion:@escaping () -> Void) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.emit(kConnectUser, nickname) {
            completion()
        }
        
    }
        
    func leaveChatRoom(nickname: String, completion:@escaping () -> Void) {
        
        guard let socket = manager?.defaultSocket else{
            return
        }
        
        socket.emit(kExitUser, nickname) {
            completion()
        }
    }
    
    func getMessage(completion: @escaping (_ messageInfo: Message?) -> Void) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            
            var messageInfo = [String: Any]()
            
            guard let nickName = dataArray[0] as? String,
                let message = dataArray[1] as? String,
                let date = dataArray[2] as? String else{
                    return
            }
            
            messageInfo["nickname"] = nickName
            messageInfo["message"] = message
            messageInfo["date"] = date
            
            guard let data = UIApplication.jsonData(from: messageInfo) else {
                return
            }

            do {
                let messageModel = try JSONDecoder().decode(Message.self, from: data)
                completion(messageModel)
                
            } catch let error {
                print("Something happen wrong here...\(error)")
                completion(nil)
            }
        }
    }
    
    func sendMessage(message: String, withNickname nickname: String,completion:@escaping () -> Void ) {
        
        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.emit("chatMessage", nickname, message) {
            completion()
        }
    }
    
    func participantList(completion: @escaping (_ userList: [User]?) -> Void) {

        guard let socket = manager?.defaultSocket else {
            return
        }
        
        socket.on(kUserList) { [weak self] (result, ack) -> Void in

            guard result.count > 0,
                  let _ = self,
                let user = result.first as? [[String: Any]],
                let data = UIApplication.jsonData(from: user) else {
                    return
            }


            do {
                let userModel = try JSONDecoder().decode([User].self, from: data)

                completion(userModel)

            } catch let error {
                print("Something happen wrong here...\(error)")
                completion(nil)
            }
        }
    }
   
}
