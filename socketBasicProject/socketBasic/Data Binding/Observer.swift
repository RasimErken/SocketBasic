//
//  Observer.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//
import Foundation

class KxSwift<T> {
    
    typealias Observer = (T) -> ()
    var observer: Observer?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(_ listner: Observer?) {
        self.observer = listner
    }
    
    func subscribe(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
    
}
