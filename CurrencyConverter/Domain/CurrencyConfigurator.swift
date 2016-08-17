//
//  CurrencyConverterConfigurator.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco on 15/08/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation
import UIKit

extension MainViewController: CurrencyPresenterOutput {

}

extension CurrencyBussinesLogic: MainViewControllerOutput {
    
}

extension CurrencyPresenter: CurrencyBusinessLogicOutput {
    
}

class CurrencyConverterConfigurator {
    
    // MARK: Object lifecycle
    
    class var sharedInstance: CurrencyConverterConfigurator {
        struct Static {
            static var instance: CurrencyConverterConfigurator?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = CurrencyConverterConfigurator()
        }
        return Static.instance!
    }
    
    // MARK: Configuration
    
    func configure(viewController: MainViewController) {
        
        //let router = NoticiasYEventosRouter()
        //router.viewController = viewController
        
        let presenter = CurrencyPresenter()
        presenter.output = viewController
        
        let interactor = CurrencyBussinesLogic()
        interactor.output = presenter
        
        viewController.output = interactor
    }
}




