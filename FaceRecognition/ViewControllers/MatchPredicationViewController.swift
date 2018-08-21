//
//  MatchPredicationViewController.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 21/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit
import AWSRekognition

class MatchPredicationViewController: UIViewController {

    var rekognitionClient: AWSRekognition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rekognitionClient = AWSRekognition.default()
    }

}
