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
        static let AccessKeyID = "AccessKey"
        static let SecretAccessKey = "SecretAccessKey"
    }
    
    struct AWSCollection {
        static let Name = "ImageCollections"
        static let FaceMatchThreshold = 75
        static let MaxFaces = 2
    }
    
    struct ImageKeys {
        static let PNGExtension = "png"
        static let JPGEExtension = "jpge"
        static let JPGEImageCompressionScale = 1.0
    }
    
}

