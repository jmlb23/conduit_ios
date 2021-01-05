//
//  File.swift
//  MediumClone
//
//  Created by jmlb23 on 25/12/20.
//

import os
import Alamofire

extension Logger {
    private static let shared: Logger = Logger()
    
    static func d(symbol: String = "🐞", _ message: String) {
        shared.debug("\(symbol) [Debug] \(message)")
    }
    
    static func e(symbol: String =  "❌", _ message: String) {
        shared.error("\(symbol) [Error] \(message)")
    }
    
    static func i(symbol: String = "ℹ️", _ message: String) {
        shared.info("\(symbol) [Info] \(message)")
    }
    
    static func w(symbol: String = "⚠️", _ message: String) {
        shared.warning("\(symbol) [Warn] \(message)")
    }
}


extension Optional where Wrapped : Collection{
    
    func orEmpty() -> some Collection {
        return self ?? EmptyCollection<Wrapped.Element>() as! Wrapped
    }
}
