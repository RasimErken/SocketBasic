//
//  ChatViewModel.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//
//
import Foundation
import Combine
import UIKit

final class ChatViewModel {
    
    let pass = PassthroughSubject<[User],Error>()
    
    func fetchParticipantList(_ name: String) -> AnyPublisher<[User],Error> {
        Deferred {
            Future<[User],Error> { promixe in
                SocketHelper.shared.participantList { userList in
                    guard let userList = userList else {
                        return
                            
                    }
                    var filterUsers = userList

                    if let index = filterUsers.firstIndex(where: {$0.nickname == name}) {
                        filterUsers.remove(at: index)
                    }
    
                    self.pass.send(filterUsers)

                }
                
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()

    }
}

