//
//  MatchPredictViewController.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 21/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class MatchPredictViewController: UIViewController {

    @IBOutlet private weak var sourceImageView: UIImageView!
    @IBOutlet private weak var targetImageView: UIImageView!
    @IBOutlet private weak var comparisonResultLabel: UILabel!
    
    var sourceImage: UIImage!

    private let faceRekognitionHandler = FaceRekognitionHandler()
    private let imageReaderHandler = ImagerReaderHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sourceImage == nil {
            print("source or target image is nil, please check it has valid data")
            return
        }
        
        sourceImageView.image = sourceImage
        if findMatching() == false {
            comparisonResultLabel.textColor = UIColor.red
            comparisonResultLabel.text = "Sorry, couldn't find the matching, please enroll"
        }
    }
    
    private func findMatching() -> Bool {
        let images = imageReaderHandler.imagesAvailableLocally()
        if images?.count == 0 {
            return false
        }
        
        for image in images! {
            faceRekognitionHandler.isEqual(source: sourceImage, target: image, completion: { (result) in
                if result {
                    //self.targetImageView.image = image
                    self.comparisonResultLabel.textColor = UIColor.green
                    self.comparisonResultLabel.text = "Successfully find the matching!"
                }
            })
        }
        
        return false
    }

}
