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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    
    // MARK: - Setup functions
    func setupView() {
        self.backgroundColor = .brown
        self.contentView.backgroundColor = .cyan
        
        self.flagImage.layer.cornerRadius = self.flagImage.bounds.height * 0.5
        self.flagImage.layer.masksToBounds = true
    }
    
    // MARK: - Module functions
    func configureCell(currency: Currency?) {
        guard currency != nil else { return }
        nameLabel.text = currency!.name
        valueLabel.text = currency!.value
        flagImage.image = UIImage(named: "usa")
    }
}
