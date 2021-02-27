//
//  EmployeeListModule.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.

import UIKit

class EmployeeListModule: IModule {
    let appRouter: IAppRouter
    private var router: EmployeeListRouter!

    init(_ appRouter: IAppRouter) {
        self.appRouter = appRouter
        self.router = EmployeeListRouter(appRouter: self.appRouter)
    }

    func presentView(parameters: [String: Any]) {
        router.presentView(parameters: parameters)
    }

    func createView(parameters: [String: Any]) -> UIViewController? {
        return router.create(parameters: parameters)
    }
}
