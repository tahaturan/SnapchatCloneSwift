//
//  SettingsVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func logOutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSginInVC", sender: nil)
        } catch  {
            ApplicationConstants.makeAlert(title: "ERROR!", message: "Erorr!", viewController: self)
        }
        
        
    }
    
}
