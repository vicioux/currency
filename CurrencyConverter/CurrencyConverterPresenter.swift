//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation


/* OUTPUT */
protocol CurrencyConverterPresenterOutput {
    func setCurrencies(currencies:[Currency])
    func showConversion(conversion:[CurrencyDomain])
    func showMessage(message: String)
}

/* INPUT */
protocol CurrencyConverterPresenterInput {
    func presentCurrencies(currencies:[Currency])
    func presentConversion(conversion:[CurrencyDomain])
    func presentMessage(message: String?)
}

class ConsultaPersonalPresenter : CurrencyConverterPresenterInput {
    
    var output: CurrencyConverterPresenterOutput!
    
    func presentMessage(message: String?) {
        self.output.showMessage(message!)
    }
    
    func presentCurrencies(currencies: [Currency]) {
        self.output.setCurrencies(currencies)
    }
    
    func presentConversion(conversion: [CurrencyDomain]) {
        self.output.showConversion(conversion)
    }

}

