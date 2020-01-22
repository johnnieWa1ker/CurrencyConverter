//
//  AssemblyModelBuilder.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 14.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createCoursesModule (router: RouterProtocol) -> UIViewController
    func createDateChangeModule (router: RouterProtocol) -> UIViewController
//    func createCurrencySelectionModule (router: RouterProtocol) -> UIViewController
//    func createConverterModule (router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createCoursesModule(router: RouterProtocol) -> UIViewController {
        let view = CoursesViewController(nibName: "CoursesViewController", bundle: nil)
        let networkService = NetworkService()
        let presenter = CoursesPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDateChangeModule(router: RouterProtocol) -> UIViewController {
        let view = DateChangeViewController(nibName: "DateChangeViewController", bundle: nil)
        let networkService = NetworkService()
        let presenter = DateChangePresenter()
        view.presenter = presenter
        return view
    }
    
//    func createConverterModule(router: RouterProtocol) -> UIViewController {
//        let view = ConverterViewController()
//        let networkService = NetworkService()
//        let presenter =
//        view.presenter = presenter
//        return view
//    }
    
//    func createCurrencySelectionModule(router: RouterProtocol) -> UIViewController {
//        let view = CurrencySelectionViewController()
//        let networkService = NetworkService()
//        let presenter =
//        view.presenter = presenter
//        return view
//    }
    
}

