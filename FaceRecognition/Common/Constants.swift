//
//  Constants.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 20/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import Foundation

struct Constants {
    
    struct AWSAccessKeys {
        static let AccessKeyID = "AccessKeyID"
        static let SecretAccessKey = "SecretAccessKey"
    }
    
    struct AWSCollection {
        static let Name = "Name"
        static let FaceMatchThreshold = 75
        static let MaxFaces = 2
    }
    
    struct ImageKeys {
        static let PNGExtension = "png"
        static let JPGEExtension = "jpge"
        static let JPGEImageCompressionScale = 1.0
    }
    
    struct StreamService  {
        static let streamProcessorName = "streamProcessorName"
        static let kvStreamArn = "kvStreamArn"
        static let kdStreamArn = "kdStreamArn"
        static let iamRoleArn = "iamRoleArn"
        static let threshold: Float = 0.0
    }
    
}

