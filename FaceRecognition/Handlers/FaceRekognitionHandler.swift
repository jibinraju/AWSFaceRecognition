//
//  FaceRekognitionHandler.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 21/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation
import AWSRekognition

class FaceRekognitionHandler {
    
    var rekognitionClient: AWSRekognition!
    var faceSimilarityThreshold: Int!
    
    init(_ similarityThreshold: Int? = 70) {
        rekognitionClient = AWSRekognition.default()
        faceSimilarityThreshold = similarityThreshold
    }
    
    func isEqual(source: UIImage, target: UIImage, completion: @escaping (Bool) -> Void ) {
        let sourceRekongitionImage = AWSRekognitionImage()
        sourceRekongitionImage?.bytes = UIImagePNGRepresentation(source)
        
        let targetRekongitionImage = AWSRekognitionImage()
        targetRekongitionImage?.bytes = UIImagePNGRepresentation(target)

        
        if targetRekongitionImage == nil || sourceRekongitionImage == nil {
            completion(false)
        }
        
        let compareRequest = AWSRekognitionCompareFacesRequest()
        compareRequest?.sourceImage = sourceRekongitionImage
        compareRequest?.targetImage = targetRekongitionImage
        compareRequest?.similarityThreshold = NSNumber.init(value: faceSimilarityThreshold)
        
        rekognitionClient.compareFaces(compareRequest!) { (compareFaceResponse, error) in
            var result = false
            if compareFaceResponse != nil && (compareFaceResponse?.faceMatches?.count)! > 0 {
                let comparedFace = compareFaceResponse?.faceMatches?.first
                if (comparedFace?.similarity?.intValue)! > Int(self.faceSimilarityThreshold) {
                    result = true
                }
            }
            
            completion(result)
        }
        
    }
    
}
