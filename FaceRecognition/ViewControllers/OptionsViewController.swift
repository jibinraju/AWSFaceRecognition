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
            } else {
                print("CollectionArn: \(String(describing: awsRekognitionCreateCollectionResponse?.collectionArn))")
                print("Status code : \(String(describing: awsRekognitionCreateCollectionResponse?.statusCode))")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnrollmentSegue" {
            let vc = segue.destination as! CameraViewController//ImageSourceOptionsViewController
            vc.awsService = awsService
            vc.isEnrollment = true
        }
        else if segue.identifier == "Recogize" {
            let vc = segue.destination as! CameraViewController//CaptureViewController
            vc.awsService = awsService
            vc.isEnrollment = false
        }
    }
    
}

