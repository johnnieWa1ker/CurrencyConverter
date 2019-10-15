//
//  Model.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 11.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

// Data example:
// <Valute ID="R01010">
// <NumCode>036</NumCode>
// <CharCode>AUD</CharCode>
// <Nominal>1</Nominal>
// <Name>¿‚ÒÚ‡ÎËÈÒÍËÈ ‰ÓÎÎ‡</Name>
// <Value>16,0102</Value>

class Currency {
    var valute: String?
    var numCode: String?
    var charCode: String?
    var nominal: String?
    var nominalDouble: Double?
    var name: String?
    var value: String?
    var valueDouble: Double?
}

class Model: NSObject, XMLParserDelegate {
    
    // MARK:  What does this mean? For what?
    static let shared = Model()
    
    var currencies: [Currency] = []
    var dateFromFile: String = ""
    
    // Path to the data file if can't load file from cbr.ru
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/data.xml"
        
        if FileManager.default.fileExists(atPath: path) {
            return path
        }
         return Bundle.main.path(forResource: "data", ofType: "xml")!
    }
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML)
    }
    
    // MARK: Load data from cbr.ru and save it in app catalog
    // http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
    
    func loadXMLFile (date: Date?) {
        
        // Create a URL depending on the week day
        var strUrl = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        
        if date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy "
            strUrl = strUrl + dateFormatter.string(from: date!)
        }
        
        let url = URL(string: strUrl)
        
        // Generate URL request
        let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            if error == nil {
                // Specify the path to save the file
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/data.xml"
                let urlForSave = URL(fileURLWithPath: path)
                
                // Save file from URL
                do {
                    try data?.write(to: urlForSave)
                    print(path)
                    print("File is load ")
                    // Script processing for which a new file should be loaded first
                    self.parseXML()
                    
                } catch {
                    print("Error wthen save data: \(error.localizedDescription )")
                    
                }
                
            } else {
                print("Error when load XMLfile: \(error!.localizedDescription)")
            }
        }
        
        // Request URL
        task.resume()
    }
    
    // MARK: Parse date from XML file and put them in currencies: [Currency] & send a notification to the application about update data
    // ????
    // Where exactly does it say that the function should be applied to data received from the Internet????
    // ????
    func parseXML () {
        
        // Reset old data before loading new ones
        currencies = [ ]
        
        let parser = XMLParser(contentsOf: urlForXML)
        
        // ?????
        // The two lines below are unclear why???????
        // ?????
        parser?.delegate = self
        parser?.parse()
        
        print("Update data")
        
        // Send notification in application
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
    }
    
    var newCurrency: Currency?
    
    // ????
    // How exactly does the DidStartElement / didEndElement mechanism work????
    // ????
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs" {
            if let newDateFromFile = attributeDict["Date"] {
                dateFromFile = newDateFromFile 
            }
        }
        
        
        // As soon as the parser finds the word "Valute", we create a variable currentCurrency that corresponds to the Currecy class
        if elementName == "Valute" {
            newCurrency = Currency()
        }
    }

    var newCharacter: String = ""
    
    // ????
    // Where exactly does it say that the function should be applied to data received from the Internet?
    // ????
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        newCharacter = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "NumCode" {
            newCurrency?.numCode = newCharacter
        }
        if elementName == "CharCode" {
             newCurrency?.charCode = newCharacter
        }
        if elementName == "Nominal" {
            newCurrency?.nominal = newCharacter
            newCurrency?.nominalDouble = Double(newCharacter.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Name" {
             newCurrency?.name = newCharacter
        }
        if elementName == "Value" {
            newCurrency?.value = newCharacter
            newCurrency?.valueDouble = Double(newCharacter.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Valute" {
            currencies.append(newCurrency!)
        }
    }
    
}
