//
//  ImageSourceOptionsViewController.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 20/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class ImageSourceOptionsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var imagePickerController: UIImagePickerController!
    var awsService: AWSService!
    var progressAlertViewController: UIAlertController!
    
    @IBOutlet weak var statusLabel: UILabel!
    
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
        picker.dismiss(animated: true) {
            self.progressAlertViewController = CommonUtilities.showActivityAlert(title: "Uploading the image to AWS backend...")
            self.present(self.progressAlertViewController, animated: true, completion: nil)
        }
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //let imageWriterHandler = ImageWriterHandler(imageToSave: pickedImage)
            //if imageWriterHandler.save() {
            awsService.sendData(image: pickedImage) { (awsRekognitionIndexFacesResponse, error) in
                if error == nil {
                    self.statusLabel.textColor = UIColor.green
                    self.statusLabel.text = "Successfully Enrolled"
                }
                else {
                    self.statusLabel.textColor = UIColor.red
                    self.statusLabel.text = "Failed to Enrolled, Try again"
                }
                self.progressAlertViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

