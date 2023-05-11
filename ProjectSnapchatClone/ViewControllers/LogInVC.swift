//
//  LogInVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import Firebase

class LogInVC: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func logInButtonClicked(_ sender: Any) {
        if userNameTextField.text != nil && passwordTextField.text != nil {
            
            signInUser()

        }else{
            ApplicationConstants.makeAlert(title: "Error", message: "Email/Password ?", viewController: self)
        }
    }
    

}


//MARK: SignIn user Firebase
extension LogInVC{
    
    func signInUser()  {
        Auth.auth().signIn(withEmail: self.userNameTextField.text!, password: passwordTextField.text!) { result, error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "ERROR!", viewController: self)
            }else{
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                
            }
        }
    }
    
}
