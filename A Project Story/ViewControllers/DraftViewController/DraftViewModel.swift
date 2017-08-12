//
//  DraftViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class DraftViewModel {
    
    private var listOfSteps = [Step]()
    private var project: Project?
    private var step: Step?
    
    func appendStep(with data: Step) {
        listOfSteps.append(data)
    }
    
    func assignData(with data: Project) {
        project = data
    }
    
    func projectTitle() -> String {
        return project?.title ?? ""
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        switch section {
        case 0:
            return listOfSteps.count
        default:
            return -1
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) -> Step {
        return listOfSteps[indexPath.row]
    }
        
}
