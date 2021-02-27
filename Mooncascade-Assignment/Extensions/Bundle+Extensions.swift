//
//  Bundle+Extensions.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//

import UIKit

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version: String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
