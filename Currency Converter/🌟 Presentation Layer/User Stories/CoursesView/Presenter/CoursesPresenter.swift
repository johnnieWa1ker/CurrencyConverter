//
//  CoursesViewPresenter.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 14.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit
import Foundation

protocol CoursesViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol CoursesViewPresenterProtocol: class {
    var currency: [Currency]? { get set }
    var date: Date? { get set }
    
    var baseCurrencyValue: [Double] { get set }
    var baseCurrency: Currency? { get set }
    
    var conversionCurrencyValue:  [Double]? { get set }
    var conversionCurrency: Currency? { get set }

    init(view: CoursesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func calculateConversionCurrencyValue(baseCurrency: Currency?, conversionCurrency: Currency?) -> [Double]
    
    func getCurrency()
    func changeDate()
}

class CoursesPresenter: CoursesViewPresenterProtocol {

    weak var view: CoursesViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var currency: [Currency]?
    
    var baseCurrencyValue = [1.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0]
    var baseCurrency: Currency?
    
    var conversionCurrencyValue:  [Double]?
    var conversionCurrency: Currency?
    
    var date: Date?
    
    required init(view: CoursesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getCurrency() {
        networkService.getData(date: date) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let currency):
                    self.currency = currency
                    
                    // Валюты по умолчанию:
                    // USD: currency[10]
                    // EUR: currency[11]
                    self.baseCurrency = currency[10]
                    self.conversionCurrency = currency[11]
                    
                   
                    self.conversionCurrencyValue = self.calculateConversionCurrencyValue(baseCurrency: self.baseCurrency, conversionCurrency: self.conversionCurrency)
//                    self.calculateConversionCurrencyValue(baseCurrency: self.baseCurrency, conversionCurrency: self.conversionCurrency)
                    
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    internal func calculateConversionCurrencyValue(baseCurrency: Currency?, conversionCurrency: Currency?) -> [Double] {
        
        guard (baseCurrency != nil) && (conversionCurrency != nil) else { print("Some error"); return [0.0]}
        
        let currencyRatio = conversionCurrency!.valueDouble! / baseCurrency!.valueDouble!
        
        var t = [Double]()
        for i in baseCurrencyValue {
            t.append(i * currencyRatio)
        }
        
        return t
    }
    
    func changeDate() {
        router?.goToSettingsView(date: date)
        
    }
}
