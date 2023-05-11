//
//  UploadVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit

class UploadVC: UIViewController {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(recognizer)
    }
    


    @IBAction func uploadButtonClicked(_ sender: Any) {
    }
    
}


//MARK: selected image for gallery
extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func choosePicture()  {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        
        uploadImageView.image = selectedImage
        self.dismiss(animated: true)
    }
}
