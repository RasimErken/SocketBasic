//
//  Realm.swift
//  socketBasic
//
//  Created by rasim rifat erken on 18.10.2022.
//  Copyright © 2022 mac-0005. All rights reserved.
//@objc dynamic

import Foundation
import RealmSwift

class StoredMessage: Object {
    
    @Persisted var date: String?
    @Persisted var message: String?
    @Persisted var nickname: String?
    @Persisted var senderNickname: String?
    
    convenience init(date: String, message: String,nickname:String,senderNickname:String) {
        self.init()
        self.date = date
        self.message = message
        self.nickname = nickname
        self.senderNickname = senderNickname
    }
    
}

