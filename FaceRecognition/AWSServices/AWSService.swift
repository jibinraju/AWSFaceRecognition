//
//  AWSService.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 23/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit
import AWSRekognition

enum AWSServiceError : Error {
    case unableToInitializeAWSRekognitionCollectionRequest
    case unableToInitializeAWSRekognitionindexFaceRequest
    case unableToInitializeAWSRekognitionSearchFaceRequest
}

class AWSService: IAWSService {
    
    private var awsRekognitionClient:AWSRekognition!
    
    init() {
        awsRekognitionClient = AWSRekognition.default()
    }

    func createCollection(collectioName: String? = Constants.AWSCollection.Name, completion: @escaping (_ response: AWSRekognitionCreateCollectionResponse?, _ error: Error?) -> Void) {
        guard let request = AWSRekognitionCreateCollectionRequest() else {
            puts("Unable to initialize AWSRekognitionCreateCollectionRequest.")
            completion(nil, AWSServiceError.unableToInitializeAWSRekognitionCollectionRequest)
            return
        }
        
        request.collectionId = collectioName
        awsRekognitionClient.createCollection(request) { (response:AWSRekognitionCreateCollectionResponse?, error:Error?) in
             //DispatchQueue.main.sync {
            completion(response, error)
            //}
        }
    }
    
    func sendData(collectioName: String? = Constants.AWSCollection.Name, image: UIImage, completion: @escaping (_ response: AWSRekognitionIndexFacesResponse?, _ error: Error?) -> Void) {
        guard let request = AWSRekognitionIndexFacesRequest() else {
            puts("Unable to initialize AWSRekognitionindexFaceRequest.")
            completion(nil, AWSServiceError.unableToInitializeAWSRekognitionindexFaceRequest)
            return
        }
        request.collectionId = collectioName
        request.detectionAttributes = ["ALL", "DEFAULT"]
        request.externalImageId = NSUUID().uuidString
        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage!.bytes = UIImageJPEGRepresentation(image, CGFloat(Constants.ImageKeys.JPGEImageCompressionScale))
        request.image = rekognitionImage 
        awsRekognitionClient.indexFaces(request) { (awsRekognitionIndexFacesResponse, error) in
             //DispatchQueue.main.sync {
                completion(awsRekognitionIndexFacesResponse, error)
            //}
        }
    }
    
    func findData(collectioName: String? = Constants.AWSCollection.Name, image: UIImage, completion: @escaping (_ response:AWSRekognitionSearchFacesByImageResponse?, _ error:Error?) -> Void) {
        guard let request = AWSRekognitionSearchFacesByImageRequest() else {
            puts("Unable to initialize AWSRekognitionSearchfacerequest.")
            completion(nil, AWSServiceError.unableToInitializeAWSRekognitionSearchFaceRequest)
            return
        }
        request.collectionId = collectioName
        request.faceMatchThreshold = NSNumber.init(value: Constants.AWSCollection.FaceMatchThreshold)
        request.maxFaces = NSNumber.init(value: Constants.AWSCollection.MaxFaces)
        let rekognitionImage = AWSRekognitionImage()
        rekognitionImage!.bytes = UIImageJPEGRepresentation(image, CGFloat(Constants.ImageKeys.JPGEImageCompressionScale))
        request.image = rekognitionImage
        awsRekognitionClient.searchFaces(byImage:request) { (response:AWSRekognitionSearchFacesByImageResponse?, error:Error?) in
             DispatchQueue.main.sync {
                completion(response, error)
            }
        }
    }
}
