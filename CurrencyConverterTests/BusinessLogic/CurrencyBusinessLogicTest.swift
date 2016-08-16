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
        
        func presentCurrencies(currencies:[Currency]) {
            showCurrency = true
        }
        
        func presentConversion(conversion:[CurrencyDomain]) {
            showConvertedCurrency = true
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
