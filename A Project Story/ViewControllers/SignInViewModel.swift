//
//  SignInViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/23/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class SignInViewModel {
    
    let apiCommunicator = APICommunicator()
    
    func signIn(email: String, password: String, completion: ((Error?) -> Void)?) {
        apiCommunicator.signIn(with: email, password: password) { (error) in
            completion?(error)
        }
    }
    
    
}
