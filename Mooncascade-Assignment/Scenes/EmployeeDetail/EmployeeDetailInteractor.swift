//
//  EmployeeDetailInteractor.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 27.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.
import UIKit

protocol IEmployeeDetailInteractor: class {
	var parameters: [String: Any]? { get }
}

class EmployeeDetailInteractor: IEmployeeDetailInteractor {
    var presenter: IEmployeeDetailPresenter!
    var parameters: [String: Any]?

    init(presenter: IEmployeeDetailPresenter) {
    	self.presenter = presenter
    }
}
