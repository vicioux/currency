//
//  ICurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

protocol ICurrencyRepository {
    func findCurrencies(completion: (success: [Currency]!, fail: NSError?) -> Void) -> Void
}