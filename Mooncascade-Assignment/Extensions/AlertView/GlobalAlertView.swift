//
//  GlobalAlertView.swift
//  Mooncascade-Assignment
//
//  Created by Can TOKER on 26.02.2021.
//

import UIKit

struct MoonCascadeAction {
    let title: String
    var action: ((UIAlertAction) -> Void)?
    var type: UIAlertAction.Style = .default
}

enum GlobalAlert {
    case simpleAlert(title: String, message: String, action: MoonCascadeAction)
    case alert(title: String, message: String, firstAction: MoonCascadeAction, secondAction: MoonCascadeAction, thirdAction: MoonCascadeAction? = nil)
    case actionSheet(title: String, message: String, actions: [MoonCascadeAction])
    
    func show(_ vc: UIViewController) {
        switch self {
        case .simpleAlert(let title, let message, let action):
            showAlert(on: vc, title: title, message: message, actions: [action], style: .alert)
        case .alert(title: let title, message: let message, let firstAction, let secondAction, let thridAction):
            var actionsArr = [firstAction, secondAction]
            if let unwrappedThirdAction = thridAction {
                actionsArr.append(unwrappedThirdAction)
            }
            showAlert(on: vc, title: title, message: message, actions: actionsArr, style: .alert)
        case .actionSheet(title: let title, message: let message, let actions):
            showAlert(on: vc, title: title, message: message, actions: actions, style: .actionSheet)
        }
    }
    
    func show() {
        guard let rootViewController = UIApplication.shared.getKeyWindow()?.rootViewController else { return }
        show(rootViewController)
    }
    
    private func showAlert(on: UIViewController, title: String, message: String, actions: [MoonCascadeAction], style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.type, handler: action.action)
            alert.addAction(alertAction)
        }
        
        on.present(alert, animated: true, completion: nil)
    }
}
