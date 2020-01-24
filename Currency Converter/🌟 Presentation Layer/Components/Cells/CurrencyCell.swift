//
//  CoursesTableViewCell.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 20.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var baseCurrencyValueLabel: UILabel!
    @IBOutlet weak var currencyConversionValueLabel: UILabel!
    
    
    // MARK: - Setup functions
    func setupView() {
        self.backgroundColor = .brown
        self.contentView.backgroundColor = .cyan
        
    }
    
    // MARK: - Module functions
    func configureCell(baseCurrency: Double, currencyConversion: Double) {
        
        baseCurrencyValueLabel.text = String(baseCurrency)
        currencyConversionValueLabel.text = String(currencyConversion)
    }
}
