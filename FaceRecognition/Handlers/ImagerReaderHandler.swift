//
//  ImagerReaderHandler.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 21/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ImagerReaderHandler: ImageHandler {

    func imagesAvailableLocally() -> [UIImage]? {
        let fileDirectory = fileDirectoryPath
        if fileDirectory == nil {
            return nil
        }
        
        var images = Array<UIImage>()
        do {
            let fileList = try FileManager.default.contentsOfDirectory(atPath: fileDirectory)
            for fileName in fileList {
                if fileName.hasSuffix(fileExtension) {
                    let filePath = fileDirectory + "/" + fileName
                    let image = UIImage(contentsOfFile: filePath)
                    if image != nil {
                        images.append(image!)
                    }
                }
            }
        }
        catch {
            print("failed to get files available locally")
            return nil
        }
    
        return images
    }
    
}
