//
//  TestCurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class TestCurrencyRepository : ICurrencyRepository {
    
    static let sharedInstance = TestCurrencyRepository()
    
    class var sharedDispatchInstance: TestCurrencyRepository {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: TestCurrencyRepository? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = TestCurrencyRepository()
        }
        
        return Stactic.instance!
    }
    
    func findCurrencies(completion: (success: [Currency]!, fail: NSError?) -> Void) {
        var currencies = [Currency]()
        
        let sterlingCurrency = Currency(keyName:"GBP", rate:0.7712)
        let euroCurrency = Currency(keyName:"EUR", rate:0.89622)
        let yenCurrency = Currency(keyName:"JPY", rate:101.96)
        let brazilRealCurrency = Currency(keyName:"BRL", rate:3.1625)
        
        currencies.append(sterlingCurrency)
        currencies.append(euroCurrency)
        currencies.append(yenCurrency)
        currencies.append(brazilRealCurrency)
        
        completion(success: currencies, fail: nil)
    }
}