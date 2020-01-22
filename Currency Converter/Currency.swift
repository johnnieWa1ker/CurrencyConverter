//
//  CurrencyData.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 15.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

// Example:
// <Valute ID="R01010">
//   <NumCode>036</NumCode>
//   <CharCode>AUD</CharCode>
//   <Nominal>1</Nominal>
//   <Name>Австралийский доллар</Name>
//   <Value>16,0102</Value>
// </Valute>

struct Currency {
    var numCode: Int?
    var charCode: String?
    var nominal: String?
    var nominalDouble: Double?
    var name: String?
    var value: String?
    var valueDouble: Double?
}
