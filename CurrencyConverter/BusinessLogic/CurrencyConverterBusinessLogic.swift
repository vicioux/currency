//
//  CurrencyConverterBusinessLogic.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

/* INPUT */
protocol CurrencyConverterBusinessLogicOutput {
    
    func presentCurrencies(currencies:[Currency])
    func presentConversion(conversion:[CurrencyDomain])
    func presentMessage(message: String?)
}

/* OUTPUT */
protocol CurrencyConverterBusinessLogicInput {
    
    func convertCurrency(currencies:[Currency]?,value:Int?)
    func loadCurrencies()
}

class CurrencyConverterBussinesLogic : CurrencyConverterBusinessLogicInput {
    
    
    var output: CurrencyConverterBusinessLogicOutput!
    var repositoryLocator = RepositoryLocator().currencyRepository()
    
    func loadCurrencies() {
        repositoryLocator.findCurrencies { (success, fail) in
            if(fail != nil) {
                self.output.presentMessage(fail?.description)
            } else {
                self.output.presentCurrencies(success)
            }
        }
    }
    
    func convertCurrency(currencies: [Currency]?, value: Int?) {
        var convertedCurrencies = [CurrencyDomain]()
        
        for currency in currencies! {
            convertedCurrencies.append(CurrencyDomain.init(keyName: currency.keyName, rate: getCurrencyConversion(currency, value: Double(value!))))
        }
        
        self.output.presentConversion(convertedCurrencies)
        
    }
    
    func getCurrencyConversion(currency: Currency,value: Double?) -> String {
        return FormatHelper.formattedCurrency(currency.rate! * Double(value ?? 0), symbol: setSymbol(currency.keyName!))
    }
    
    func setSymbol(keyName: String) -> String {
        switch keyName {
        case CurrencyEnum.GBP.rawValue: return "£"
        case CurrencyEnum.EUR.rawValue: return "€"
        case CurrencyEnum.JPY.rawValue: return "¥"
        case CurrencyEnum.BRL.rawValue: return "R$"
        default : return "$"
        }
    }
    
}
