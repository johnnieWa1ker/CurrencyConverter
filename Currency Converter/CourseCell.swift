//
//  CourseCell.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 21.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    @IBOutlet weak var labelCharCode: UILabel!
    
    func initCell(currency: Currency) {
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.name
        labelCourse.text = currency.value
        labelCharCode.text = currency.charCode
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
