//
//  CurrencyDomain.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class CurrencyDomain {
    
    var name : String? = ""
    var keyName : String?
    var rate : String?
    var flag : String? = ""
    
    init(name: String? ,keyName: String?, rate: String?, flag: String?) {
        self.name = name
        self.keyName = keyName
        self.rate = rate
        self.flag = flag
    }
    
}