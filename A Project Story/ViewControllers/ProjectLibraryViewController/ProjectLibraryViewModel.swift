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
        switch section {
        case 0:
            return listOfDrafts.count
        case 1:
            return listOfProjects.count
        default:
            return -1
        }
    }
    
    func projectTitleAt(indexPath: IndexPath) -> String {
        return listOfProjects[indexPath.row].title
    }
    
    func didSelectItemAt(indexPath: IndexPath) -> Project {
        let section = indexPath.section
        if section == 0 {
            return listOfDrafts[indexPath.row]
        } else {
            return listOfProjects[indexPath.row]
        }
    }
}
