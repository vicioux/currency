//
//  String+Validations.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/15/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

extension String {

    /**
     - returns: The resulting string where ALL leading and trailing whitespaces and new line characters
     */
    func trimLeadingAndTrailingWhiteSpacesAndNewLines() -> String {
        return stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    var isNumeric: Bool {
        let predicate = NSPredicate(format:"SELF MATCHES '[0-9]+'")
        return predicate.evaluateWithObject(trimLeadingAndTrailingWhiteSpacesAndNewLines())
    }
    
    var isNumericShort: Bool {
        let predicate = NSPredicate(format:"SELF MATCHES '[0-9]{0,20}'")
        return predicate.evaluateWithObject(trimLeadingAndTrailingWhiteSpacesAndNewLines())
    }

    var length: Int {
        return self.characters.count
    }
}