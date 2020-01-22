//
//  XmlParser.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 17.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

protocol CurrencyParser {
    func parseData(data: Data, completion: @escaping ([Currency]) -> Void)
}

class Parser: NSObject, XMLParserDelegate, CurrencyParser {
    
    var currencies: [Currency] = []

    private var parser: XMLParser?
    private var parseGroup: DispatchGroup?

    private var currentCurrency: Currency?
    private var currentCharacters: String = ""
    
    
    func parseData(data: Data, completion: @escaping ([Currency]) -> Void) {
        self.parser = XMLParser(data: data)
        self.parser?.delegate = self
        
        self.parseGroup = DispatchGroup()
        self.parseGroup?.enter()
        
        self.parser?.parse()
        
        self.parseGroup?.notify(queue: .global(), execute: {
            completion(self.currencies)
        })
    }
        
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Valute" {
            currentCurrency = Currency()
        }
    }
    
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
            currentCurrency?.nominal = currentCharacters
            currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        
        if elementName == "Name" {
            currentCurrency?.name = currentCharacters
        }
        
        if elementName == "Value" {
            currentCurrency?.value = currentCharacters
            currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        
        if elementName == "Valute" {
            currencies.append(currentCurrency!)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parseGroup?.leave()
    }
    
}

