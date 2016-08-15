//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit


/* INPUT */
protocol MainViewControllerInput {
    
    func setCurrencies(currencies:[Currency])
    func showConversion(conversion:[CurrencyDomain])
    func showMessage(message: String)
}

/* OUTPUT */
protocol MainViewControllerOutput {
    
    func convertCurrency(currencies:[Currency]?,value:Int?)
    func loadCurrencies()
}

class MainViewController: UIViewController,MainViewControllerInput {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var currencyTableView: UITableView!
    
    var output: CurrencyConverterBussinesLogic!
    
    var currenciesList : [Currency]?
    var convertedCurrencies : [CurrencyDomain]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.loadCurrencies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CurrencyConverterConfigurator.sharedInstance.configure(self)
    }
    
    func setCurrencies(currencies: [Currency]) {
        self.currenciesList = currencies
        self.output.convertCurrency(self.currenciesList, value: 5)
    }
    
    func showConversion(conversion: [CurrencyDomain]) {
        self.convertedCurrencies = conversion
        self.currencyTableView.reloadData()
    }
    
    func showMessage(message: String) {
        print(message)
    }

    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.convertedCurrencies != nil && convertedCurrencies!.count > 0{
           return self.convertedCurrencies!.count
        } else {
           return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LabelCell", forIndexPath: indexPath)
        cell.textLabel?.text = self.convertedCurrencies![indexPath.row].rate
        return cell
    }
    
}

