//
//  EmployeeListTableViewDataSource.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 27.02.2021.
//

import UIKit

final class EmployeeListTableViewDataSource: NSObject {
    // MARK: Private Variables
    private let presenter: EmployeeListPresenter

    init(presenter: EmployeeListPresenter) {
        self.presenter = presenter
    }
    
}

extension EmployeeListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.viewModelList[indexPath.row].position +  presenter.viewModelList[indexPath.row].lastName
        if presenter.viewModelList[indexPath.row].showContactImage == true {
            cell.accessoryType = .detailDisclosureButton
        }
         return cell
    }
}
extension EmployeeListTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.openDetailVC(viewModel: presenter.viewModelList[indexPath.row])

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        self.presenter.displayContact(contact: presenter.viewModelList[indexPath.row].contactValue!)
    }
    
    
}
