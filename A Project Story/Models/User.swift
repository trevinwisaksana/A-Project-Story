//
//  User.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/23/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class User {
    
    var username: String
    var email: String
    let password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
}
