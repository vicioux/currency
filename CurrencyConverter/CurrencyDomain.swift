//
//  CurrencyDomain.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class CurrencyDomain {
    
    var keyName : String?
    var rate : String?
    
    init(keyName: String?, rate: String?) {
        self.keyName = keyName
        self.rate = rate
    }
    
}