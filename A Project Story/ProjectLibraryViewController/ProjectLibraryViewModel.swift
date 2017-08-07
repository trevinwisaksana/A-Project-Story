//
//  ProjectLibraryViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

////////////////
// View Model //
////////////////

import Foundation

// MARK: - View Model
final class ProjectLibraryViewModel {
    
    private var listOfProjects = [Project]()
    private var listOfDrafts = [Project]()
    
    func appendDraft(with data: Project) {
        listOfDrafts.append(data)
    }
    
    func appendProject(with data: Project) {
        listOfProjects.append(data)
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        if section == 0 {
            return listOfDrafts.count
        } else if section == 1 {
            return listOfProjects.count
        } else {
            return -1
        }
    }
    
    func projectTitleAt(indexPath: IndexPath) -> String {
        return listOfProjects[indexPath.row].title
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
    }
}
