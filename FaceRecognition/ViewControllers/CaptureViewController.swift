//
//  CaptureViewController.swift
//  FaceRecognition
//
//  Created by Jibin Raju on 23/08/18.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func OnTouchCapture(_ sender: UIButton) {
        imagePickerController = createImagePickerController(imagePickerSourceType: UIImagePickerControllerSourceType.camera)
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
            picker.dismiss(animated: true) {
                self.showMatchPredictViewController(sourceImage: pickedImage)
            }
        }
        else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func showMatchPredictViewController(sourceImage: UIImage) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MatchPredictViewController") as! MatchPredictViewController
        controller.sourceImage = sourceImage
        self.show(controller, sender: self)
    }

}
