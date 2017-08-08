//
//  CreateProjectViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/7/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class CreateProjectViewModel {
    
    private var project: Project?
    
    func createProject(title: String, email: String, description: String, completion: ((NSError?, Project?) -> Void)?) {
        
        let result = validateProject(title: title, email: email)
        
        if result.isEmpty {
            project = Project(title: title, ownerEmail: email, description: description)
            guard let data = project else { return }
            completion?(nil, data)
        } else {
            let errorMessage = NSError(domain: result, code: 0, userInfo: nil)
            completion?(errorMessage, nil)
        }
    }
    
    private func validateProject(title: String, email: String) -> String {
        if title.isEmpty && email.isEmpty {
            return "titleAndEmailIsEmpty"
        } else if title.isEmpty {
            return "titleIsEmpty"
        } else if email.isEmpty {
            return "emailIsEmpty"
        }
        
        return ""
    }

}
