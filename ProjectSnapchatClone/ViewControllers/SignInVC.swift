//
//  ViewController.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 20
        signUpButton.layer.cornerRadius = 20
      
  
    }

    @IBAction func logInButtonClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
    }
    
}

