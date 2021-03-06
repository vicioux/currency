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
    
    func convert(currencies:[Currency]?, value:Int?)
    func loadCurrencies()
}

class MainViewController: UIViewController, MainViewControllerInput {

    private struct Identifier
    {
        static let currencyTableViewCell = "CurrencyTableViewCell"
    }
    
    @IBOutlet weak var currencyTextField: UITextField! {
        didSet {
            currencyTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        }
    }
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    var output: CurrencyBussinesLogic!
    
    var currenciesList : [Currency]?
    var convertedCurrencies : [CurrencyDomain]?
    
    //hardcode variable god forgiveme.
    var animationSwowed = [Bool](count: 4, repeatedValue: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.loadCurrencies()
        
        let currencyTableNib = UINib(nibName: Identifier.currencyTableViewCell, bundle: nil)
        self.currencyTableView.registerNib(currencyTableNib, forCellReuseIdentifier: Identifier.currencyTableViewCell)
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
    }
    
    func showConversion(conversion: [CurrencyDomain]) {
        self.convertedCurrencies = conversion
        self.currencyTableView.reloadData()
    }
    
    func showMessage(message: String) {
        AppNotification.show(nil, subtitle: message, type:NotificationType.Error.color)
    }
    
    func textFieldDidChange(textField: UITextField) {
       let currentText = textField.text!
       let value = Int(currentText) ?? 0
       self.output.convert(self.currenciesList, value: value)
    }
}


/* UITextFieldDelegate */
extension MainViewController: UITextFieldDelegate {

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = currencyTextField.text!
        let isDeleting = range.length == 1 && string.isEmpty
        let newLength = currentText.length + string.length - range.length
        let isWriting = !isDeleting
        
        if !string.isNumeric && isWriting {
            return false
        }
        
        return newLength <= 9
    }
}

/* UITableViewDataSource  UITableViewDelegate */
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.convertedCurrencies != nil && convertedCurrencies!.count > 0 {
           return self.convertedCurrencies!.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CurrencyTableViewCell = tableView.dequeueReusableCellWithIdentifier(Identifier.currencyTableViewCell) as! CurrencyTableViewCell
        cell.currency = self.convertedCurrencies![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if animationSwowed[indexPath.row] == false {
            
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0) {
                cell.layer.transform = CATransform3DIdentity
            }
            
            animationSwowed[indexPath.row] = true
        }
        
    }
    

}

