//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

enum CurrencyEnum : String {
    case GBP
    case EUR
    case JPY
    case BRL
}

class Currency {
    var keyName : String?
    var rate : Double?
    
    init(keyName: String?, rate: Double?) {
        self.keyName = keyName
        self.rate = rate
    }    
}