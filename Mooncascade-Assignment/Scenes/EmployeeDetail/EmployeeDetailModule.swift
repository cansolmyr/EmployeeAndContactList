//
//  EmployeeDetailModule.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 27.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.

import UIKit

class EmployeeDetailModule: IModule {
    let appRouter: IAppRouter
    private var router: EmployeeDetailRouter!

    init(_ appRouter: IAppRouter) {
        self.appRouter = appRouter
        self.router = EmployeeDetailRouter(appRouter: self.appRouter)
    }

    func presentView(parameters: [String: Any]) {
        router.presentView(parameters: parameters)
    }

    func createView(parameters: [String: Any]) -> UIViewController? {
        return router.create(parameters: parameters)
    }
}
