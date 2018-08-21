//
//  ImageWriteHandler.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 20/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ImageWriterHandler {
    
    var image: UIImage!
    
    @available(*, unavailable, message: "use the custom init")
    init() {
        
    }
    
    init(imageToSave: UIImage) {
        image = imageToSave
    }
    
    // MARK: Save
    func save() -> Bool {
        var result = false
        if image == nil {
            return result
        }
        
        do {
            let fileName = self.fileName
            let path = self.filePath()
            let filePath = path + "/" + fileName
            if let jpegData = UIImageJPEGRepresentation(image, CGFloat(ImageCompressionScale.scale)) {
                let fileURLPath = URL(fileURLWithPath: filePath)
                try jpegData.write(to: fileURLPath, options: .atomicWrite)
                result = true
            }
        }
        catch {
            print("failed to write jpeg data to disk")
        }
        
        return result
    }
    
    // MARK: Private functions
    private var fileName: String {
        get {
            return NSUUID().uuidString + ".jpeg"
        }
    }
    
    private func filePath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        return documentsPath
    }
}

