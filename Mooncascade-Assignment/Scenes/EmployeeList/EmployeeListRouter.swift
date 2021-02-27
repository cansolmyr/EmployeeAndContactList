//
//  EmployeeListRouter.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.

import UIKit

protocol IEmployeeListRouter {
    func openDetailVC(viewModel: EmployeeListModel.ViewModel)
}

class EmployeeListRouter: IEmployeeListRouter {

    var appRouter: IAppRouter

    init(appRouter: IAppRouter) {
        self.appRouter = appRouter
    }

    func presentView(parameters: [String: Any]) {
        appRouter.presentView(view: create(parameters: parameters))
    }

    func create(parameters: [String: Any]) -> EmployeeListViewController {
        let bundle = Bundle(for: type(of: self))
        let view = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: bundle)
        let presenter = EmployeeListPresenter(view: view)
        let interactor = EmployeeListInteractor(presenter: presenter)
        view.presenter = presenter
        presenter.interactor = interactor
        view.router = self
        interactor.parameters = parameters
        return view        
    }
    
    func openDetailVC(viewModel: EmployeeListModel.ViewModel) {
        appRouter.presentModule(module: Modules.employeeDetail, parameters: ["parameter": viewModel], type: .push)    
    }
}
