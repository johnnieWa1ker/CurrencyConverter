//
//  AppDelegate.swift
//  Currency Converter
//
//  Created by Johnnie Walker on 11.10.2019.
//  Copyright © 2019 Johnnie Walker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        // Создание базовых объектов
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController()
        let assemblyModelBuilder = AssemblyModelBuilder()
        
        // Инициализация первого экрана
        let router = Router(navigationController: navigationController, assemblyModelBuilder: assemblyModelBuilder)
        router.initialViewController()
        
        // Добавляем в приложение UINavigationController и UITabBarController
        navigationController.tabBarItem = UITabBarItem(title: "Ok", image: nil, selectedImage: nil)
        tabBarController.viewControllers = [navigationController]
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

