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
    var awsService: AWSService!
    var progressAlertViewController: UIAlertController!

    private let faceRekognitionHandler = FaceRekognitionHandler()
    private let imageReaderHandler = ImagerReaderHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if sourceImage == nil {
            print("source or target image is nil, please check it has valid data")
            return
        }
        
        sourceImageView.image = sourceImage
        comparisonResultLabel.text = "Searching for matching"
        progressAlertViewController = CommonUtilities.showActivityAlert(title: "find the matching...")
        present(progressAlertViewController, animated: true, completion: nil)
        findMatchingRemotly()
        /*if findMatching() == false {
            comparisonResultLabel.textColor = UIColor.red
            comparisonResultLabel.text = "Sorry, couldn't find the matching, please enroll"
        }*/
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
    
    private func findMatchingRemotly() {

        awsService.findData(image: sourceImage) { (response, error) in
            if response != nil && (response?.faceMatches?.count)! > 0 {
                //self.targetImageView.image = image
                self.comparisonResultLabel.textColor = UIColor.green
                self.comparisonResultLabel.text = "Successfully find the matching!"
            }
            else if error != nil {
                self.comparisonResultLabel.textColor = UIColor.red
                self.comparisonResultLabel.text = error?.localizedDescription
            }
            else {
                self.comparisonResultLabel.textColor = UIColor.red
                self.comparisonResultLabel.text = "Sorry, couldn't find the matching, please enroll"
            }
            self.progressAlertViewController.dismiss(animated: true, completion: nil)
        }
    }
}
