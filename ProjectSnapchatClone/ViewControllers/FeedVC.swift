//
//  FeedVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import Firebase

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
    }

}

//MARK: getUserInfo FireBase
extension FeedVC{
    func getUserInfo()  {
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "ERROR!", viewController: self)
            }else{
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    for document in snapshot!.documents{
                        if let userName = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.userName = userName
                        }
                    }
                    
                }
                
                
                
            }
        }
    }
}
