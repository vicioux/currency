//
//  CurrencyBusinessLogicTest.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/15/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

@testable import CurrencyConverter
import XCTest

class CurrencyBusinessLogicTest: XCTestCase {

    var testSubject: CurrencyBussinesLogic!
    
    func setupCurrencyBusinessLogic()
    {
        testSubject = CurrencyBussinesLogic()
    }
    
    override func setUp() {
        super.setUp()
        setupCurrencyBusinessLogic()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    // MARK: Mocks Classes
    
    class CurrencyBusinessOutputSpy: CurrencyBusinessLogicOutput {
        
        var showMensaje = false
        var showCurrency = false
        var showConvertedCurrency = false
        var currenciesValue: [Currency]?
        var conversionValue: [CurrencyDomain]?
        
        func presentCurrencies(currencies:[Currency]) {
            showCurrency = true
            currenciesValue = currencies
        }
        
        func presentConversion(conversion:[CurrencyDomain]) {
            showConvertedCurrency = true
            conversionValue = conversion
        }
        
        func presentMessage(message: String?) {
            showMensaje = true
        }
    }
    
    class CurrencyRepositorioSpy: ICurrencyRepository
    {
        // MARK: Method call expectations
        var hasCurrencyData = false
        var data = [Currency]()
        var error: NSError?
        
        // MARK: Spied methods
        
        func findCurrencies(completion: (success: [Currency]!, fail: NSError?) -> Void) {
            hasCurrencyData = true
            completion(success: data, fail: error)
        }
         
    }
    
    func testShouldReturnCurrencies()
    {
        // Given
        let currencyBusinessOutputSpy = CurrencyBusinessOutputSpy()
        testSubject.output = currencyBusinessOutputSpy
        let repositorySpy = CurrencyRepositorioSpy()
        testSubject.repositoryLocator = repositorySpy
        // When
        testSubject.loadCurrencies()
        
        // Then
        XCTAssert(repositorySpy.hasCurrencyData, "should return data from the API.")
    }
    
    func testShouldPresentConversion()
    {
        // Given
        let currencyBusinessOutputSpy = CurrencyBusinessOutputSpy()
        testSubject.output = currencyBusinessOutputSpy
        let repositorySpy = CurrencyRepositorioSpy()
        testSubject.repositoryLocator = repositorySpy
        
        // When
        var currencies = [Currency]()
        
        let sterlingCurrency = Currency(keyName:"GBP", rate:0.7712)
        let euroCurrency = Currency(keyName:"EUR", rate:0.89622)
        let yenCurrency = Currency(keyName:"JPY", rate:101.96)
        let brazilRealCurrency = Currency(keyName:"BRL", rate:3.1625)
        
        currencies.append(sterlingCurrency)
        currencies.append(euroCurrency)
        currencies.append(yenCurrency)
        currencies.append(brazilRealCurrency)
        
        testSubject.convert(currencies, value: 5)
        // Then
        XCTAssert(currencyBusinessOutputSpy.showConvertedCurrency, "should return data from the API.")
    }
    
    
    func testShoulLoadCurrencies(){
        // Given
        let currencyBusinessOutputSpy = CurrencyBusinessOutputSpy()
        testSubject.output = currencyBusinessOutputSpy
        let repositorySpy = CurrencyRepositorioSpy()
        testSubject.repositoryLocator = repositorySpy
        
        // When
        
        var currencies = [Currency]()
        
        let sterlingCurrency = Currency(keyName:"GBP", rate:0.7712)
        let euroCurrency = Currency(keyName:"EUR", rate:0.89622)
        let yenCurrency = Currency(keyName:"JPY", rate:101.96)
        let brazilRealCurrency = Currency(keyName:"BRL", rate:3.1625)
        
        currencies.append(sterlingCurrency)
        currencies.append(euroCurrency)
        currencies.append(yenCurrency)
        currencies.append(brazilRealCurrency)
        
        repositorySpy.data = currencies
        testSubject.loadCurrencies()
        
        // Then
        XCTAssert(repositorySpy.hasCurrencyData, "should return data from the API.")
        XCTAssertEqual(currencyBusinessOutputSpy.currenciesValue!.count, 4, "it mys return 4 currencies from service")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
