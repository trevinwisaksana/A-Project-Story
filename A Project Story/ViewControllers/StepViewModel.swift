//
//  StepViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/10/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class StepViewModel {
    
    private var step: Step?
    
    func assignData(with step: Step) {
        self.step = step
    }
    
    func passStep() -> Step? {
        return step
    }
    
    func updateStep(title: String, description: String, completion: ((Error?) -> Void)?) {
        step?.title = title
        step?.description = description
        completion?(nil)
    }
    
}
