//
//  CommonUtilities.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 24/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class CommonUtilities {
   
    static func showAlert(message: String, okCompletion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: okCompletion)
        alertViewController.addAction(alertAction)
        
        return alertViewController
    }
    
    static func showActivityAlert(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alertController.view.addSubview(loadingIndicator)
        
        return alertController
    }
    
}
