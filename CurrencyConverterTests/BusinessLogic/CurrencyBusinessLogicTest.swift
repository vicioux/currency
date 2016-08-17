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
        
        var showMessage = false
        var showCurrency = false
        var showConvertedCurrency = false
        var currencieListValues: [Currency]?
        var conversionListValues: [CurrencyDomain]?
        
        func presentCurrencies(currencies:[Currency]) {
            showCurrency = true
            currencieListValues = currencies
        }
        
        func presentConversion(conversion:[CurrencyDomain]) {
            showConvertedCurrency = true
            conversionListValues = conversion
        }
        
        func presentMessage(message: String?) {
            showMessage = true
        }
    }
    
    class CurrencyRepositorioSpy: ICurrencyRepository {
        // MARK: Method call expectations
        var hasCurrencyData = false
        var data: [Currency]?
        var error: NSError?
        
        // MARK: Spied methods
        
        func findCurrencies(completion: (success: [Currency]!, fail: NSError?) -> Void) {
            hasCurrencyData = true
            completion(success: data, fail: error)
        }
         
    }
    
    func givenTest() -> (repositorySpy: CurrencyRepositorioSpy, currencyBusinessOutputSpy: CurrencyBusinessOutputSpy) {
        let currencyBusinessOutputSpy = CurrencyBusinessOutputSpy()
        testSubject.output = currencyBusinessOutputSpy
        let repositorySpy = CurrencyRepositorioSpy()
        testSubject.repositoryLocator = repositorySpy
        return (repositorySpy, currencyBusinessOutputSpy)
    }
    
    func getCurrenciesMock() -> [Currency] {
        var currencies = [Currency]()
        
        let sterlingCurrency = Currency(keyName:"GBP", rate:0.7712)
        let euroCurrency = Currency(keyName:"EUR", rate:0.89622)
        let yenCurrency = Currency(keyName:"JPY", rate:101.96)
        let brazilRealCurrency = Currency(keyName:"BRL", rate:3.1625)
        
        currencies.append(sterlingCurrency)
        currencies.append(euroCurrency)
        currencies.append(yenCurrency)
        currencies.append(brazilRealCurrency)
        
        return currencies
    }
    
    func testShouldPresentCurrencies() {
        // Given
        let (repositorySpy, _) = givenTest()
        
        // When
        testSubject.loadCurrencies()
        
        // Then
        XCTAssert(repositorySpy.hasCurrencyData, "should return data from the API.")
    }
    
    func testShouldPresentConversion() {
        // Given
        let (_, currencyBusinessOutputSpy) = givenTest()
        
        // When
        let currencies = getCurrenciesMock()
        
        testSubject.convert(currencies, value: 5)
        // Then
        XCTAssert(currencyBusinessOutputSpy.showConvertedCurrency, "should convert the data")
    }
    
    func testShouldLoadCurrencies() {
        // Given
        let (repositorySpy, currencyBusinessOutputSpy) = givenTest()
        
        // When
        let currencies = getCurrenciesMock()
        repositorySpy.data = currencies
        testSubject.loadCurrencies()
        
        // Then
        XCTAssert(repositorySpy.hasCurrencyData, "should return data from the API.")
        XCTAssertEqual(currencyBusinessOutputSpy.currencieListValues!.count, 4, "it must return 4 currencies from service")
    }
    
    func testShouldPresentMessage() {
        // Given
        let (repositorySpy, currencyBusinessOutputSpy) = givenTest()
        
        // When
        repositorySpy.data = nil
        repositorySpy.error = NSError(domain: "CurrencyConverter", code: 1, userInfo: [NSLocalizedDescriptionKey: "this could be any kind of error that must be presented"])
        testSubject.loadCurrencies()
        
        // Then
        XCTAssert(currencyBusinessOutputSpy.showMessage, "error message must be showed")
    }
    
    
    func testShouldConvertCurrencies() {
        // Given
        let (repositorySpy, currencyBusinessOutputSpy) = givenTest()
        
        // When
        let currencies = getCurrenciesMock()
        let testValue = 100
        
        repositorySpy.data = currencies
        testSubject.convert(currencies, value: testValue)
        
        if let convertedList = currencyBusinessOutputSpy.conversionListValues {
            for convertedItem in convertedList {
                XCTAssertEqual(convertedItem.rateValue, convertedItem.initalRate! * Double(testValue) , "Presenting fetched converted currency should properly convert the rate value")
            }
        }
        
        // Then
        XCTAssertEqual(currencyBusinessOutputSpy.conversionListValues!.count, currencies.count, "it must convert same number of currencies")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


}
