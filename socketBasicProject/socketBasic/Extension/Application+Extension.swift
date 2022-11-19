//
//  Application+Extension.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func jsonString(from object:Any) -> String? {
        
        guard let data = jsonData(from: object) else {
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func jsonData(from object:Any) -> Data? {
        
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        
        return data
    }
    
    
}

extension Date {
  func asString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.string(from: self)
  }
}
