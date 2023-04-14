//
//  ImagePickerCoordinator.swift
//  Sentimentalyst
//
//  Created by Jake Davies on 04/04/2023.
//

import UIKit

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
    
    init(parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parent.image = pickedImage
        }
        parent.isShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isShown = false
    }
}
