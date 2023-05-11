//
//  ApplicationConstants.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import Foundation
import UIKit

class ApplicationConstants {
    
    
    
    
    
    //MARK: Alert
    static func makeAlert(title:String , message:String , viewController:UIViewController)  {
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       let okActionButton = UIAlertAction(title: "Ok", style: .default)
       alertController.addAction(okActionButton)
        viewController.present(alertController, animated: true)
    }
    
}
