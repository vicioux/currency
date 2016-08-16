//
//  CurrencyConverterBusinessLogic.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

/* INPUT */
protocol CurrencyBusinessLogicOutput {
    func presentCurrencies(currencies:[Currency])
    func presentConversion(conversion:[CurrencyDomain])
    func presentMessage(message: String?)
}

/* OUTPUT */
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
                self.output.presentMessage(fail?.description)
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
            let currencyValue = getCurrencyConversion(currency, value: Double(value))
            let currencyInfo = getCurrencyInfoBy(currency.keyName!)
            
            let currencyDomain = CurrencyDomain(name: currencyInfo.name ,keyName: currency.keyName, rate: currencyValue, flag: currencyInfo.flag)
            convertedCurrencies.append(currencyDomain)
        }
        
        self.output.presentConversion(convertedCurrencies)
    }
    
    func getCurrencyConversion(currency: Currency,value: Double?) -> String {
        return FormatHelper.formattedCurrency(currency.rate! * Double(value ?? 0), symbol: getCurrencyInfoBy(currency.keyName!).symbol!)
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
