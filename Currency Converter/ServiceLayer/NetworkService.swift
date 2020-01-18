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
        
        
        // Подготавливаем дату для запроса. Если параметр даты будет отсутствовать, то вернется информация за текущий день
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        var urlParamDate = ""
        
        if date != nil {
            urlParamDate = dateFormatter.string(from: date!)
        }
        
        
        // Подготавливаем путь к данным. Если по URL ничего не вернулось, то следует использовать данные в скачанном ранее файле
        // TODO: Не уверен, что корректно отрботается запрос к локальным данным. Проверить этот кусок
        var pathForXml: String {
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/data.xml"
            
            if FileManager.default.fileExists(atPath: path) {
                return path
            }
            return Bundle.main.path(forResource: "data", ofType: "xml")!
        }
        
        let urlString = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=" + urlParamDate
        guard let url = URL(string: urlString) else { return }
        
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                // Когда получаем данные, применяем к ним парсер и возвращаем массив объектов Currency
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

