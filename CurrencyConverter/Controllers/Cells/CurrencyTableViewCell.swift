//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Sergio Orozco  on 8/15/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagName: UILabel!
    @IBOutlet weak var currencyKeyName: UILabel!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    
    var currency: CurrencyDomain? {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        currencyKeyName.text = currency!.keyName
        currencyName.text = currency!.keyName
        currencyValue.text = currency!.rate
    }
}