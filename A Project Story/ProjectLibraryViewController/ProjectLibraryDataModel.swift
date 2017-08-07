//
//  ProjectLibraryDataModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

////////////////
// Data Model //
////////////////

// MARK: - Data Model
final class ProjectDataModel {
    var projectName: String
    let projectOwner: String
    
    init(projectName: String, projectOwner: String) {
        self.projectName = projectName
        self.projectOwner = projectOwner
    }
}
