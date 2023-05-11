//
//  UserSingleton.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import Foundation

class UserSingleton {
    static let sharedUserInfo = UserSingleton()
    var email = ""
    var userName = ""
    
    
    private init(){
        
    }
    
}
