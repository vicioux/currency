//
//  FormatHelper.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class FormatHelper {
    
    class func formattedCurrency(amount: Double, symbol: String) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.currencySymbol = symbol
        return formatter.stringFromNumber(amount)!
    }
    
}