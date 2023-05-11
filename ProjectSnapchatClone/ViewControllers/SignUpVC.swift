//
//  SignUpVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        if userNameTextField.text != nil && passwordTextField.text != nil && emailTextField.text != nil {
            addUserFirebase()
        }else{
            ApplicationConstants.makeAlert(title: "Error", message: "Email/Username/Password ?", viewController: self)
        }
    }
}


//MARK: Add User Firebase
extension SignUpVC{
    func addUserFirebase()  {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { auth , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!", viewController: self)
            }else{
                
                let fireStore = Firestore.firestore()
                let userDictionary = ["email":self.emailTextField.text! ,"username":self.userNameTextField.text!] as![String:Any]
                
               fireStore.collection("UserInfo").addDocument(data: userDictionary)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}


