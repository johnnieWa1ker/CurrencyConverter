//
//  XmlParser.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 17.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

protocol CurrencyParser {
    func parseData(data: Data, completion: ([Currency]?) -> Void)
}

class Parser: NSObject, XMLParserDelegate, CurrencyParser {
    
    var currencies: [Currency] = []
    var currentCurrency: Currency?
    
    func parseData(data: Data, completion: ([Currency]?) -> Void) {
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            if elementName == "Valute" {
                currentCurrency = Currency()
            }
        }
        
        var currentCharacters: String = ""
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            currentCharacters = string
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            
            if elementName == "NumCode" {
                currentCurrency?.numCode = Int(currentCharacters)
            }
            
            if elementName == "CharCode" {
                currentCurrency?.charCode = currentCharacters
            }
            
            if elementName == "Nominal" {
                currentCurrency?.nominal = Int(currentCharacters)
            }
            
            if elementName == "Name" {
                currentCurrency?.name = currentCharacters
            }
            
            if elementName == "Value" {
                currentCurrency?.value = Double(currentCharacters)
            }
            
            if elementName == "/Valute" {
                currencies.append(currentCurrency!)
            }
        }
        
        completion(currencies)
    }    
}

