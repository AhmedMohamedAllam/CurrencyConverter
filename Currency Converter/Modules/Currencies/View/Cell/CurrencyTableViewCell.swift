//
//  CurrencyTableViewCell.swift
//  Currency Converter
//
//  Created by Ahmed Allam on 13/01/2021.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI(currency: Currency){
        flagImageView.image = currency.image
        currencyNameLabel.text = currency.name
        currencyValueLabel.text = "\(currency.value)"
    }
    
}
