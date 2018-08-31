//
//  CreateCollection.swift
//  FaceRecognition
//
//  Created by capgemini on 29/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit
import AWSRekognition

class CreateCollection: NSObject {
    
    func setUpAWSConfiguration() {
        // AWS Configuration
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.EUWest1, identityPoolId: "Your identity pool ID")
        let configuration = AWSServiceConfiguration(region: .EUWest1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    func createCollection() {
        let colRequest = AWSRekognitionCreateCollectionRequest()
        colRequest?.collectionId = "CapgeminiFaceCollection"
        AWSRekognition.default().createCollection(colRequest!) { (response, error) in
            if error == nil {
                debugPrint("face collection is successfully created. \(String(describing: response))")
            } else {
                debugPrint(error.debugDescription)
            }
        }
    }
    
    func savePicturesinAWSS3(imageData: Data) {
        let indexReq = AWSRekognitionIndexFacesRequest()
        indexReq?.collectionId = "CapgeminiFaceCollection"
        indexReq?.externalImageId = "configure_your_user_id"
        
        let image = AWSRekognitionImage()
        image?.bytes = imageData
        
        indexReq?.image = image
        AWSRekognition.default().indexFaces(indexReq!) { (response, error) in
            if error == nil {
                debugPrint("saved Picture \(String(describing: response))")
            } else {
                debugPrint(error.debugDescription)
            }
        }
    }
}
