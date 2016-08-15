//
//  RepositoryLocator.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class RepositoryLocator {
    
    static let sharedInstance = RepositoryLocator()
    
    class var sharedDispatchInstance: RepositoryLocator {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: RepositoryLocator? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = RepositoryLocator()
        }
        
        return Stactic.instance!
    }
    
    
    func currencyRepository() -> ICurrencyRepository{
        if (Constants.useTestRepo) {
            return TestCurrencyRepository.sharedInstance
        } else {
            return CurrencyRepository.sharedInstance
        }
    }
}