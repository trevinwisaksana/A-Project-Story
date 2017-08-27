//
//  SignUpViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/23/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class SignUpViewModel {
    
    let apiCommunicator = APICommunicator()
    
    func signUp(with username: String, email: String, password: String, completion: ((Error?) -> Void)?) {
        
        apiCommunicator.signUp(with: email, password: password) { (error) in
            completion?(error)
        }
    }
    
}
