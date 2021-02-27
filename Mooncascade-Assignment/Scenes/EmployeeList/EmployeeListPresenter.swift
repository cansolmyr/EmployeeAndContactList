//
//  EmployeeListPresenter.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.
import UIKit
import Contacts
protocol IEmployeeListPresenter: class {
    var dataSource: [EmployeeListModel.Response.Employees] { get }
    var tableViewdataSource: EmployeeListTableViewDataSource { get }
    var contacts: [FetchedContact] { get }
    var viewModelList: [EmployeeListModel.ViewModel] { get }
    
    func getEmployeeListFromTalinnSuccess(data: EmployeeListModel.Response)
    func getEmployeeListFromTalinnFailure()
    func getEmployeeListFromTartuSuccess(data: EmployeeListModel.Response)
    func getEmployeeListFromTartuFailure()
    func viewDidLoad()
    func getAllEmployees()
    func displayContact(contact: CNContact)
    func openDetailVC(viewModel: EmployeeListModel.ViewModel)
}

class EmployeeListPresenter: IEmployeeListPresenter {
    private(set) var contacts = [FetchedContact]()
    private(set) var viewModelList = [EmployeeListModel.ViewModel]()
    lazy var tableViewdataSource = EmployeeListTableViewDataSource(presenter: self)
    weak var view: IEmployeeListViewController!
    var interactor: IEmployeeListInteractor!
    private(set) var dataSource = [EmployeeListModel.Response.Employees]() {
        didSet {
            // MARK: Gropuped Position and sorted LastName
            dataSource = dataSource.sorted{$0.lastName < $1.lastName}.sorted{$0.position < $1.position}.unique(map: {$0.firstNameSurname})
            // MARK: Generating ViewModel and Compare With Phone Contact List
            for item in dataSource {
                viewModelList.append(.init(contactValue: nil, showContactImage: false, firstName: item.firstName, lastName: item.lastName, position: item.position, contactDetails: item.contactDetails, projects: item.projects))
            }
            
            viewModelList = viewModelList.sorted{$0.lastName < $1.lastName}.sorted{$0.position < $1.position}.unique(map: {$0.firstNameSurname})
            for contact in contacts {
                var i = 0
                for data in viewModelList {
                    if data.firstNameSurname == contact.firstName + " " + contact.lastName {
                        viewModelList[i].contactValue = contact.contactValue
                        viewModelList[i].showContactImage = true
                    }
                    i += 1
                }
            }
            self.view.updateTableView()
        }
    }
    
    init(view: IEmployeeListViewController) {
        self.view = view
    }
    
    func viewDidLoad() {
        getAllEmployees()
        fetchContacts()
    }
    
    func displayContact(contact: CNContact) {
        view.displayContactUI(contact:contact)
    }
    
    private func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            
            if granted {
                print("access granted")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        print(contact.givenName)
                        self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName))
                        print(self.contacts)
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
    func openDetailVC(viewModel: EmployeeListModel.ViewModel) {
        view.openDetailVC(viewModel:viewModel)
    }
    
    func getAllEmployees() {
        viewModelList = [EmployeeListModel.ViewModel]()
        interactor.requestTalinnEmployeeList()
        interactor.requestTartuEmployeeList()
    }
    
    func getEmployeeListFromTalinnSuccess(data: EmployeeListModel.Response ) {
        dataSource.append(contentsOf: data.employees)
    }
    func getEmployeeListFromTalinnFailure() {
        view.showError()
    }
    
    func getEmployeeListFromTartuSuccess(data: EmployeeListModel.Response) {
        dataSource.append(contentsOf: data.employees)
    }
    
    func getEmployeeListFromTartuFailure() {
        view.showError()
    }
}
