//
//  NetworkService.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 14.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(date: Date?, completion: @escaping (Result<[Currency]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getData(date: Date?, completion: @escaping (Result<[Currency]?, Error>) -> Void) {
        
        // Подготавливаем дату для запроса
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        var urlParamDate = ""
        
        if date != nil {
            urlParamDate = dateFormatter.string(from: date!)
        }
        
        // Подготавливаем путь к данным
        var pathForXml: String {
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/data.xml"
            
            if FileManager.default.fileExists(atPath: path) {
                return path
            }
            
            return Bundle.main.path(forResource: "data", ofType: "xml")!
        }
        
        let urlForXml = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=" + urlParamDate
        guard let url = URL(string: urlForXml) else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let parser = Parser()
                let obj = parser.parseData(data: data!) { (currencies) in
                    return currencies
                }
                
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
            
        } .resume()
    }
}

