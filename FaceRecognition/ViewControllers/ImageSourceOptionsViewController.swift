//
//  ImageSourceOptionsViewController.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 20/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ImageSourceOptionsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onTouchCameraOptions(_ sender: UIButton) {
        imagePickerController = createImagePickerController(imagePickerSourceType: UIImagePickerControllerSourceType.camera)
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func onTouchImageGalleryOptions(_ sender: UIButton) {
        imagePickerController = createImagePickerController(imagePickerSourceType: UIImagePickerControllerSourceType.photoLibrary)
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Private functions
    func createImagePickerController(imagePickerSourceType: UIImagePickerControllerSourceType) -> UIImagePickerController? {
        var imagepickerController: UIImagePickerController? = nil
        if UIImagePickerController.isSourceTypeAvailable(imagePickerSourceType) {
            imagepickerController = UIImagePickerController()
            imagepickerController?.delegate = self
            imagepickerController?.sourceType = imagePickerSourceType;
            imagepickerController?.allowsEditing = false
        }
        else {
            let imageSourceTye = imagePickerSourceType == UIImagePickerControllerSourceType.camera ? "Camera"  : "PhotoLibrary"
            let alertController = UIAlertController(title: "Warning", message: "System doesn't has capability to show" + imageSourceTye + ", please check it", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
        
        return imagepickerController;
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageWriterHandler = ImageWriterHandler(imageToSave: pickedImage)
            if imageWriterHandler.save() {
               statusLabel.textColor = UIColor.green
                statusLabel.text = "Successfully Enrolled"
            }
            else {
                statusLabel.textColor = UIColor.red
                statusLabel.text = "Failed to Enrolled, Try again"
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

