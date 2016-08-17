//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation


/* OUTPUT */
protocol CurrencyPresenterOutput {
    func setCurrencies(currencies:[Currency])
    func showConversion(conversion:[CurrencyDomain])
    func showMessage(message: String)
}

/* INPUT */
protocol CurrencyPresenterInput {
    func presentCurrencies(currencies:[Currency])
    func presentConversion(conversion:[CurrencyDomain])
    func presentMessage(message: NSError)
}

class CurrencyPresenter : CurrencyPresenterInput {
    
    var output: CurrencyPresenterOutput!
    
    func presentMessage(message: NSError) {
        let error = CustomError.ErrorFrom(message)
        self.output.showMessage(error.description)
    }
    
    func presentCurrencies(currencies: [Currency]) {
        if currencies.count > 0 {
           self.output.setCurrencies(currencies)
           return
        }
    }
    
    func presentConversion(conversion: [CurrencyDomain]) {
        self.output.showConversion(conversion)
    }

}

