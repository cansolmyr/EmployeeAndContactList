//
//  EmployeeListModel.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//  Copyright (c) 2021 Can TOKER. All rights reserved.


import UIKit
import Contacts
struct EmployeeListModel {
    
    struct Response: Codable {
        var employees: [Employees]
        
        struct Employees: Codable {
            let firstName: String
            let lastName: String
            let position: String
            let contactDetails: ContactDetails
            let projects: [String]?
            var firstNameSurname: String {
                return firstName + " " + lastName
            }
            
            enum CodingKeys: String, CodingKey {
                case firstName = "fname"
                case lastName = "lname"
                case position = "position"
                case contactDetails = "contact_details"
                case projects = "projects"
            }
        }
    }
    
    struct ContactDetails: Codable {
        let email: String?
        let phone: String?
    }
    
    struct ViewModel {
        var contactValue: CNContact?
        var showContactImage = false
        let firstName: String
        let lastName: String
        let position: String
        let contactDetails: ContactDetails
        let projects: [String]?
        var firstNameSurname: String {
            return firstName + " " + lastName
        }
    }
}

struct FetchedContact {
    var firstName: String
    var lastName: String
}

extension FetchedContact: Equatable {
    static func ==(lhs: FetchedContact, rhs: FetchedContact) -> Bool{
        return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
}
extension FetchedContact {
    var contactValue: CNContact {
        let contact = CNMutableContact()
        contact.givenName = firstName
        contact.familyName = lastName
        return contact.copy() as! CNContact
    }
    
    init?(contact: CNContact) {
        
        let firstName = contact.givenName
        let lastName = contact.familyName
        self.init(firstName: firstName, lastName: lastName)
    }
}
