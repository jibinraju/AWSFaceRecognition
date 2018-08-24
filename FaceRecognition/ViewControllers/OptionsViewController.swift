//
//  OptionsViewController.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 20/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    private var awsService: AWSService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        awsService = AWSService()
        awsService.createCollection { (awsRekognitionCreateCollectionResponse, error) in
            if error != nil && (error! as NSError).code != 11 {
                let alertViewController = CommonUtilities.showAlert(message: (error?.localizedDescription)!)
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnrollmentSegue" {
            let vc = segue.destination as! ImageSourceOptionsViewController
            vc.awsService = awsService
        }
        else if segue.identifier == "Recogize" {
            let vc = segue.destination as! CaptureViewController
            vc.awsService = awsService
        }
    }
    
}

