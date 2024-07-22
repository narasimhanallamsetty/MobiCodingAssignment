//
//  AlertViewController+Extension.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 21/07/24.
//


import Foundation
import UIKit

//This is an extension for showing alert through out the program.
extension UIViewController {
    func showAlert (msg:String) {
        let alertController = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: okTitle, style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
