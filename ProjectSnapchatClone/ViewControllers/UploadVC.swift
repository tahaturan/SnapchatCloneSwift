//
//  UploadVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadVC: UIViewController {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(recognizer)
    }
    


    @IBAction func uploadButtonClicked(_ sender: Any) {
        uploadImage()
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


//MARK: Upload Image Firebase
extension UploadVC{
    func uploadImage()  {
        
        // Storage
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data) { metadata , error in
                if error != nil {
                    ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "ERROR!", viewController: self)
                }else{
                    
                    imageReferance.downloadURL { url , error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //FireStore
                            let fireStore = Firestore.firestore()
                            
                            fireStore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.userName).getDocuments { snapshot, error in
                                if error != nil {
                                    ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!", viewController: self)
                                }else{
                                    
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        for document in snapshot!.documents{
                                            
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String]{
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDictionary = ["imageUrlArray":imageUrlArray] as [String:Any]
                                                
                                                fireStore.collection("Snaps").document(documentId).setData(additionalDictionary, merge: true) { error in
                                                    if error == nil{
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(named: "select")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        let snapDictionary = ["imageUrlArray":[imageUrl!], "snapOwner":UserSingleton.sharedUserInfo.userName , "date":FieldValue.serverTimestamp()] as [String:Any]
                                        
                                        fireStore.collection("Snaps").addDocument(data: snapDictionary) { error in
                                            if error != nil {
                                                ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "ERROR!", viewController: self)
                                            }else{
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImageView.image = UIImage(named: "select")
                                            }
                                        }
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
}
