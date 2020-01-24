//
//  CoursesViewPresenter.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 14.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import Foundation

protocol CoursesViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol CoursesViewPresenterProtocol: class {
    var currency: [Currency]? { get set }
    var date: Date? { get set }
    var baseCurrencyValue: Double? { get set }
    var currencyConversionValue: Double? { get set }

    init(view: CoursesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func getCurrency()
    func calculateCurrencyRatio(baseCurrency: Currency?, currencyConversion: Currency?)
    func changeDate()
}

class CoursesPresenter: CoursesViewPresenterProtocol {
    
//    var baseValue: [Int] = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    weak var view: CoursesViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var currency: [Currency]?
    
    var baseCurrencyValue: Double?
    var currencyConversionValue: Double?
    
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
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func calculateCurrencyRatio(baseCurrency: Currency?, currencyConversion: Currency?) {
        
        guard (baseCurrency != nil) && (currencyConversion != nil) else { return }
        
        let currencyRatio = currencyConversion!.valueDouble! / baseCurrency!.valueDouble!
        
        baseCurrencyValue = currencyConversion?.valueDouble!
        currencyConversionValue = currencyRatio
    }
    
    func changeDate() {
        router?.changeDate(date: date)
        
    }
    
    
}
