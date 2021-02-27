//
//  EmployeeListInteractor.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.
import UIKit

protocol IEmployeeListInteractor: class {
	var parameters: [String: Any]? { get }
    func requestTalinnEmployeeList()
    func requestTartuEmployeeList()
}

class EmployeeListInteractor: IEmployeeListInteractor {
    var presenter: IEmployeeListPresenter!
    var parameters: [String: Any]?

    init(presenter: IEmployeeListPresenter) {
    	self.presenter = presenter
    }
    
    func requestTartuEmployeeList() {
        ServiceLayer.request(router: Router.talinJobEmployeeList) { (result:Result<EmployeeListModel.Response, Error>) in
            switch result {
            case .success:
                try? self.presenter.getEmployeeListFromTalinnSuccess(data: result.get())
            case .failure:
                self.presenter.getEmployeeListFromTalinnFailure()
            }
        }
    }
    
    func requestTalinnEmployeeList() {
        ServiceLayer.request(router: Router.tartuJobEmployeeList) { (result:Result<EmployeeListModel.Response, Error>) in
            switch result {
            case .success:
                try? self.presenter.getEmployeeListFromTartuSuccess(data:result.get())
            case .failure:
                self.presenter.getEmployeeListFromTartuFailure()
            }
        }
    }
}
