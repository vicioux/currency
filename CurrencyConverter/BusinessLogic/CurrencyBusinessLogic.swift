//
//  CurrencyConverterBusinessLogic.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

/* OUTPUT */
protocol CurrencyBusinessLogicOutput {
    func presentCurrencies(currencies:[Currency])
    func presentConversion(conversion:[CurrencyDomain])
    func presentMessage(message: NSError)
}

/* INPUT */
protocol CurrencyBusinessLogicInput {
    func convert(currencies:[Currency]?, value:Int?)
    func loadCurrencies()
}

class CurrencyBussinesLogic : CurrencyBusinessLogicInput {
    
    var output: CurrencyBusinessLogicOutput!
    var repositoryLocator = RepositoryLocator().currencyRepository()
    
    struct CurrencyInfo
    {
        var name: String?
        var flag: String?
        var symbol: String?
    }
    
    func loadCurrencies() {
        repositoryLocator.findCurrencies { (success, fail) in
            if (fail != nil) {
                self.output.presentMessage(fail!)
            } else {
                self.output.presentCurrencies(success)
            }
        }
    }
    
    func convert(currencies: [Currency]?, value: Int?) {
        var convertedCurrencies = [CurrencyDomain]()
        guard let currencies = currencies else { return }
        guard let value = value else { return }
        
        for currency in currencies {
            let calculatedCurrency = getCurrencyConversion(currency.rate, value: value)
            let currencyInfo = getCurrencyInfoBy(currency.keyName!)
            
            //by effects of the proof i made this format in business logic but i know i could be in the presenter.
            let currencyValue = FormatHelper.formattedCurrency(calculatedCurrency, symbol: currencyInfo.symbol!)
            let currencyDomain = CurrencyDomain(name: currencyInfo.name ,keyName: currency.keyName, rate: currencyValue, flag: currencyInfo.flag)
            currencyDomain.rateValue = calculatedCurrency
            currencyDomain.initalRate = currency.rate
            
            convertedCurrencies.append(currencyDomain)
        }
        
        self.output.presentConversion(convertedCurrencies)
    }
    
    func getCurrencyConversion(rate: Double?, value: Int?) -> Double {
        guard let newRate = rate else { return Double(0.0) }
        guard let newValue = value else { return Double(0.0) }
        
        return newRate * Double(newValue)
    }
    
    func getCurrencyInfoBy(key: String) -> CurrencyInfo {
        switch key {
        case CurrencyEnum.GBP.rawValue: return CurrencyInfo(name: "Pound sterling", flag: FormatHelper.emojiFlag(countryCode: "gb"), symbol: "£")
        case CurrencyEnum.EUR.rawValue: return CurrencyInfo(name: "Euro", flag: FormatHelper.emojiFlag(countryCode: "eu"), symbol: "€")
        case CurrencyEnum.JPY.rawValue: return CurrencyInfo(name: "Japanese Yen", flag: FormatHelper.emojiFlag(countryCode: "jp"), symbol: "¥")
        case CurrencyEnum.BRL.rawValue: return CurrencyInfo(name: "Brazilian Real", flag: FormatHelper.emojiFlag(countryCode: "br"), symbol: "R$")
        default : return CurrencyInfo(name: "US Dollar", flag: FormatHelper.emojiFlag(countryCode: "us"), symbol: "$")
        }
    }
    
}
