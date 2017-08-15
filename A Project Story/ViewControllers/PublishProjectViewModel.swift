//
//  PublishProjectViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class PublishProjectViewModel {
    
    private var project: Project?
    
    func assignProject(data: Project) {
        project = data
    }
    
    func passProjectData() -> Project? {
        return project
    }
    
}
