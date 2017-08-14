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
    var didEnlargeDraftSection = false
    
    func appendDraft(with data: Project) {
        listOfDrafts.append(data)
    }
    
    func insertProjectDraft(at index: Int, data: Project) {
        listOfDrafts.insert(data, at: index)
    }
    
    func appendProject(with data: Project) {
        listOfProjects.append(data)
    }
    
    func showMoreDrafts() {
        didEnlargeDraftSection = true
    }
    
    func showLessDrafts() {
        didEnlargeDraftSection = false
    }
    
    func listOfDraftsCount() -> Int {
        return listOfDrafts.count
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        switch section {
        case 0:
            let numberOfDrafts = listOfDrafts.count
            if didEnlargeDraftSection {
                return numberOfDrafts
            } else if numberOfDrafts == 0 {
                return 0
            } else {
                return 1
            }
        case 1:
            return listOfProjects.count
        default:
            return -1
        }
    }
    
    func projectTitleAt(indexPath: IndexPath) -> String {
        if didEnlargeDraftSection {
            return listOfDrafts[indexPath.row].title
        } else {
            return listOfDrafts[0].title
        }
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
