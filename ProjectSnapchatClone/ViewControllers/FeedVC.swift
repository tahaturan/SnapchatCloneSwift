//
//  FeedVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let fireStoreDatabase = Firestore.firestore()
    
    var snapArray = [SnapModel]()
    var choosenSnap : SnapModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        getUserInfo()
        getSnapsFromFirebase()

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

//MARK: TableView Islemleri

extension FeedVC:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        let user = snapArray[indexPath.row]
        cell.userNameLabel.text = user.userName
        cell.feedImageView.sd_setImage(with: URL(string: user.imageArray[0]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSnap = snapArray[indexPath.row]
        self.choosenSnap = selectedSnap
        
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC"{
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = self.choosenSnap
            
        }
    }
    
    
}

//MARK: Firebase veri ceme
extension FeedVC{
    func getSnapsFromFirebase()  {
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error", viewController: self)
            }else{
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArray.removeAll()
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        
                        if let userName = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour{
                                        if difference >= 24 {
                                            //Delete
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete()
                                        }else{
                                            //TIMELEFT -> SnapVC
                                           
                                            let snap = SnapModel(userName: userName, imageArray: imageUrlArray, date: date.dateValue() , timeDifferenge: 24 - difference)
                                            self.snapArray.append(snap)
                                        }
                                        
                             
                                    }
                                }
                            }
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
}
