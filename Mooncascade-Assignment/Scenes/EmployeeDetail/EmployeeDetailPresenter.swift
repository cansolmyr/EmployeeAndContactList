//
//  EmployeeDetailPresenter.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 27.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.
import UIKit

protocol IEmployeeDetailPresenter: class {
	func viewDidLoad()
    var tableViewDataSource: [String] { get }
    var viewModel:EmployeeListModel.ViewModel? {get}
}

class EmployeeDetailPresenter: IEmployeeDetailPresenter {
    private (set) var tableViewDataSource = [String]()
    private (set )var viewModel: EmployeeListModel.ViewModel?
	weak var view: IEmployeeDetailViewController!
    var interactor: IEmployeeDetailInteractor!
	
	init(view: IEmployeeDetailViewController) {
		self.view = view
	}
    func viewDidLoad() {
        guard let vm = interactor.parameters?["parameter"] as? EmployeeListModel.ViewModel else { return }
        tableViewDataSource = vm.projects ?? [String]()
        viewModel = vm
        view.updateUI()
    }
}
