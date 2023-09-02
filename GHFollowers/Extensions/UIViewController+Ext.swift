//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Vince Muller on 9/2/23.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMain(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, button: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
