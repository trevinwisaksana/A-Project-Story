//
//  NewStepViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class AddStepViewModel {
    
    private var step: Step?
    
    func addStep(title: String, description: inout String, completion: ((NSError?, Step?) -> Void)?) {
        
        let result = validateStep(title: title)
        // Prevents placeholder from being added as text
        let defaultPlaceholder = "Describe this step of your project..."
        if description == defaultPlaceholder {
            description = ""
        }
        
        if result.isEmpty {
            step = Step(title: title, description: description)
            guard let data = step else { return }
            completion?(nil, data)
        } else {
            let errorMessage = NSError(domain: result, code: 0, userInfo: nil)
            completion?(errorMessage, nil)
        }
    }
    
    private func validateStep(title: String) -> String {
        if title.isEmpty {
            return "titleIsEmpty"
        } else {
            return ""
        }
    }

}
