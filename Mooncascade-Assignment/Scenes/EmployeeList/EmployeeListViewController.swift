//
//  EmployeeListViewController.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.

import UIKit
import Contacts
import ContactsUI

protocol IEmployeeListViewController: class {
	func updateTableView()
    func displayContactUI(contact: CNContact)
    func openDetailVC(viewModel:EmployeeListModel.ViewModel)
    func showError()
}

class EmployeeListViewController: UIViewController {
    var presenter: IEmployeeListPresenter!
	var router: IEmployeeListRouter!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var employeeListTableView: UITableView!

    override func viewDidLoad() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        employeeListTableView.addSubview(refreshControl)
        
        setTableView()
        presenter.viewDidLoad()

        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Employee List"
    }
    
    func openDetailVC(viewModel:EmployeeListModel.ViewModel) {
        router.openDetailVC(viewModel: viewModel)
    }
    
    private func setTableView() {
        employeeListTableView.delegate = presenter.tableViewdataSource
        employeeListTableView.dataSource = presenter.tableViewdataSource
    }
    @objc func refresh(_ sender: AnyObject) {
        presenter.getAllEmployees()
    }
}

extension EmployeeListViewController: IEmployeeListViewController {
    func displayContactUI(contact: CNContact) {
        let contactViewController = CNContactViewController(forUnknownContact: contact)
        contactViewController.hidesBottomBarWhenPushed = true
        contactViewController.allowsEditing = false
        contactViewController.allowsActions = false
        navigationController?.pushViewController(contactViewController, animated: true)
    }
    
    func updateTableView() {
        refreshControl.endRefreshing()
        employeeListTableView.reloadData()
    }
    func showError() {
        GlobalAlert.simpleAlert(title: "Warning", message: "global_network_error", action: .init(title: "Ok")).show()
    }
}

