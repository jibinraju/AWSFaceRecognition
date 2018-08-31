//
//  IAWSService.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 23/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit
import AWSCore
import AWSRekognition

protocol IAWSService {
    
    static func defaultConfiguration()
    
    func createCollection(collectioName: String?, completion: @escaping (_ response: AWSRekognitionCreateCollectionResponse?, _ error: Error?) -> Void)
    
    func sendData(collectioName: String?, image: UIImage, completion: @escaping (_ response: AWSRekognitionIndexFacesResponse?, _ error: Error?) -> Void)
    
    func findData(collectioName: String?, image: UIImage, completion: @escaping (_ response:AWSRekognitionSearchFacesByImageResponse?, _ error:Error?) -> Void)
    
}

extension IAWSService {
    
    static func defaultConfiguration() {
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey:Constants.AWSAccessKeys.AccessKeyID , secretKey:Constants.AWSAccessKeys.SecretAccessKey)
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USWest2, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
}
