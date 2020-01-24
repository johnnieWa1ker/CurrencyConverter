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
        let view = SettingsViewViewController(nibName: "SettingsViewController", bundle: nil)
        let networkService = NetworkService()
        let presenter = SettingsPresenter()
        view.presenter = presenter
        return view
    }
}

