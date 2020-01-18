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
    
    init(view: CoursesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func getCourses()
    func changeDate()
}

class CoursesPresenter: CoursesViewPresenterProtocol {
    
    weak var view: CoursesViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var currency: [Currency]?
    var date: Date?
    
    required init(view: CoursesViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getCourses() {
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
    
    func changeDate() {
        router?.changeDate(date: date)
    }
    
    
}
