//
//  Router.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 24.02.2021.
//

import Foundation

enum Router {
    case talinJobEmployeeList
    case tartuJobEmployeeList
    
    var url: String {
        switch self {
        case .talinJobEmployeeList:
            return "https://tallinn-jobapp.aw.ee/employee_list"
             case .tartuJobEmployeeList:
            return "https://tartu-jobapp.aw.ee/employee_list/"
        }
    }
    
    var method: String {
      switch self {
      case .talinJobEmployeeList, .tartuJobEmployeeList:
          return "GET"
      }
    }
    
}
