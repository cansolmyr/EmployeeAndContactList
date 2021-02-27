//
//  AppDelegate.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 24.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppRouter.share.modules = [
            Modules.employeeList.routePath: {EmployeeListModule($0)},
            Modules.employeeDetail.routePath: {EmployeeDetailModule($0)}
        ]
        
        AppRouter.share.presentModule(module: Modules.employeeList, type: .root)
        return true
    }

}

