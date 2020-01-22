//
//  CoursesTableViewCell.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 20.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func configureCell(currency: Currency?) {
        
        guard currency != nil else { return }
        
        // MARK: Problem
        // currency проходит проверку на nil, но что-то крашится при unwrapping
        // пробовал передавать исскуственносозданный объект (не используя загрузку данных из сети) и не используя forceunwrap - точно такая же ошибка
        nameLabel.text = currency!.name
        valueLabel.text = currency!.value
        
    }
}

