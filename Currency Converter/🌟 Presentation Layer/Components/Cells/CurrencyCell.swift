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
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    @IBOutlet weak var conversionCurrencyLabel: UILabel!
    
    
    // MARK: - Setup functions
//    func setupView() {
//        self.backgroundColor = .brown
//        self.contentView.backgroundColor = .cyan
//
//    }
    
    // MARK: - Module functions
    func configureCell(baseCurrencyValue: Double?, conversionCurrencyValue: Double?) {
        
        guard (baseCurrencyValue != nil) && (conversionCurrencyValue != nil) else { print("Some currency is nil"); return }
        baseCurrencyLabel.text = String(baseCurrencyValue!)
        conversionCurrencyLabel.text = String(conversionCurrencyValue!)
    }
}
