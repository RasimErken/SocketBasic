//
//  Realm.swift
//  socketBasic
//
//  Created by rasim rifat erken on 18.10.2022.
//  Copyright © 2022 mac-0005. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private init() {
       database = try! Realm()
    }
    
    func writeData() ->  Results<StoredMessage> {

        let results: Results<StoredMessage> = database.objects(StoredMessage.self)
        return results
    }

     func addData(object: StoredMessage)   {
         do {

             try database.write {
                 database.create(StoredMessage.self, value: object)
             }
         } catch let error as NSError {
             print(error)
         }

     }
    
      func deleteAllFromDatabase()  {
           try!   database.write {
               database.deleteAll()
           }
      }
      func deleteFromDb(object: StoredMessage)   {
          try!   database.write {
             database.delete(object)
          }
      }

}
