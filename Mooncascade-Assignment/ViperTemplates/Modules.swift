//
//  Modules.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//

import Foundation

public enum Modules: Module {
    case employeeList
    case employeeDetail
    public var routePath: String {
        switch self {
        case .employeeList:
            return "\(Bundle.appName())/EmployeeList"
        case .employeeDetail:
            return "\(Bundle.appName())/EmployeeDetail"
        }
    }
}
