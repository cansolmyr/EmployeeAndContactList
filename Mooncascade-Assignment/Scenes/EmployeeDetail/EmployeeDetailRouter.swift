//
//  EmployeeDetailRouter.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 27.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.

import UIKit

protocol IEmployeeDetailRouter {
	
}

class EmployeeDetailRouter: IEmployeeDetailRouter {
    var appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView(parameters: [String: Any]) {
        appRouter.presentView(view: create(parameters: parameters))
    }

    func create(parameters: [String: Any]) -> EmployeeDetailViewController {
        let bundle = Bundle(for: type(of: self))
        let view = EmployeeDetailViewController(nibName: "EmployeeDetailViewController", bundle: bundle)
        let presenter = EmployeeDetailPresenter(view: view)
        let interactor = EmployeeDetailInteractor(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
        view.router = self
        interactor.parameters = parameters
        return view        
    }
}
