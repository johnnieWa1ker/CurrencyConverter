//
//  Router.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 14.01.2020.
//  Copyright © 2020 Johnnie Walker. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyModelBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func changeDate(date: Date?)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyModelBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyModelBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyModelBuilder = assemblyModelBuilder
    }
    
    // По умолчанию открывается экран со списком валют
    func initialViewController() {
        if let navigationController = navigationController {
            guard let CoursesViewController = assemblyModelBuilder?.createCoursesModule(router: self) else { return }
            navigationController.viewControllers = [CoursesViewController]
        }
    }
    
    // Переход на экран выбора даты
    func changeDate(date: Date?) {
        if let navigationController = navigationController {
            guard let DateChangeViewController = assemblyModelBuilder?.createDateChangeModule(router: self) else { return }
            navigationController.pushViewController(DateChangeViewController, animated: true)
        }
    }
}
