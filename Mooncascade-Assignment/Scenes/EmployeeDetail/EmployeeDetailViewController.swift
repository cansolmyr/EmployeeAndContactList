//
//  EmployeeDetailViewController.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 27.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.

import UIKit
import ContactsUI
protocol IEmployeeDetailViewController: class {
    func updateUI()
}

class EmployeeDetailViewController: UIViewController {
    var presenter: IEmployeeDetailPresenter!
	var router: IEmployeeDetailRouter!

    @IBOutlet weak var projectsTitleLabel: UILabel!
    @IBOutlet weak var showContactButtonOutlet: UIButton!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var gsmLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var projectsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
		setTableViewDelegation()
    }
    
    func setTableViewDelegation() {
        projectsTableView.dataSource = self
    }
    
    @IBAction func showContactButtonDidTap(_ sender: Any) {
        displayContactUI()
    }
    
    func displayContactUI() {
        let contactViewController = CNContactViewController(forUnknownContact: (presenter.viewModel?.contactValue)!)
        contactViewController.hidesBottomBarWhenPushed = true
        contactViewController.allowsEditing = false
        contactViewController.allowsActions = false
        navigationController?.pushViewController(contactViewController, animated: true)
    }
}
extension EmployeeDetailViewController: IEmployeeDetailViewController {
    func updateUI() {
        fullNameLabel.text = "Name :" +  presenter.viewModel!.firstNameSurname
        positionLabel.text = "Position :" +   presenter.viewModel!.position
        
        if presenter.viewModel?.contactDetails.email == nil {
            emailLabel.isHidden = true
        } else {
            emailLabel.text = "Email: " + (presenter.viewModel?.contactDetails.email)!
        }
        
        if presenter.viewModel?.contactDetails.phone == nil {
            gsmLabel.isHidden = true
        } else {
            gsmLabel.text = "GSM:" + (presenter.viewModel?.contactDetails.phone)!
        }
        
        if presenter.viewModel?.showContactImage == true {
            showContactButtonOutlet.isHidden = false
        } else {
            showContactButtonOutlet.isHidden = true
        }
        
        projectsTableView.reloadData()
    }
}
extension EmployeeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.tableViewDataSource.count == 0 {
            tableView.isHidden = true
            projectsTitleLabel.isHidden = true
        }
        return presenter.tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = presenter.tableViewDataSource[indexPath.row]
        return cell
    }
}
