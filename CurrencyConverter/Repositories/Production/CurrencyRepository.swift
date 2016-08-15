//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation
import Haneke

class CurrencyRepository: ICurrencyRepository {
    
    static let sharedInstance = CurrencyRepository()
    
    class var sharedDispatchInstance: CurrencyRepository {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: CurrencyRepository? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = CurrencyRepository()
        }
        
        return Stactic.instance!
    }
    
    func findCurrencies(completion: (success: [Currency]!, fail: NSError?) -> Void) {
        let cache = Shared.JSONCache
        let URL = NSURL(string: "http://api.fixer.io/latest?base=USD&symbols=GBP,EUR,JPY,BRL")!
        
        cache.fetch(URL: URL).onSuccess { JSON in
            let items = JSON.dictionary?["rates"] as? NSDictionary
            
            var currencies = [Currency]()
            for (key, value) in items! {
                let newKey = key as! String
                let newValue = value as! Double
                currencies.append(Currency(keyName: newKey, rate: newValue))
            }
            
            completion(success: currencies, fail: nil)
            
        }.onFailure { NSError in
            completion(success: nil, fail: NSError)
        }
    }
}