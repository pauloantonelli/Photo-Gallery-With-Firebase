//
//  AlertService.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 21/11/22.
//

import UIKit

public struct AlertService {
    static public func alert(title: String, message: String, actionTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        return alert
    }
    
    static public func actionSheet(title: String, message: String, actionTitle: String) -> UIAlertController {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: title, style: .default))
        return actionSheet
    }
}
