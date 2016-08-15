//
//  AppModel.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class AppModel: NSObject  {
    static let sharedInstance = AppModel()
    
    class var sharedDispatchInstance: AppModel {
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: AppModel? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = AppModel()
        }
        return Stactic.instance!
    }
    
    var context: RepositoryLocator;
    var currencies: [Currency]?
    
    required override init() {
        context = RepositoryLocator.sharedInstance
    }
    
    func getCurrencies(completion:(fail: NSError!) -> Void) {
        context.currencyRepository().findCurrencies { [weak self] (success, fail) in
            self!.currencies = success
            completion(fail: fail)
        }
    }
}

