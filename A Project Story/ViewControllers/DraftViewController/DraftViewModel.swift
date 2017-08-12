//
//  DraftViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class DraftViewModel {
    
    private var project: Project?
    
    func appendStep(with data: Step) {
        project?.steps.append(data)
    }

    func passStep(at indexPath: IndexPath) -> Step? {
        return project?.steps[indexPath.row] ?? nil
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
            return project?.steps.count ?? 0
        default:
            return -1
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) -> Step? {
        return project?.steps[indexPath.row] ?? nil
    }
        
}
