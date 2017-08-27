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
    let apiCommunicator = APICommunicator()
    
    func assignProject(data: Project) {
        project = data
    }
    
    func passProjectData() -> Project? {
        return project
    }
    
    // MARK: TODO: Refactor
    func removeProjectDraft(from controller: PublishProjectDelegate) {
        guard let projectLibraryViewController = controller as? ProjectLibraryViewController else {
            return
        }
        guard let index = projectLibraryViewController.viewModel.cellIndexSelected else {
            return
        }
        projectLibraryViewController.viewModel.removeProjectDraft(at: index)
    }
    
    func appendPublishedProject(from controller: PublishProjectDelegate) {
        guard let projectLibraryViewController = controller as? ProjectLibraryViewController else {
            return
        }
        
        guard let project = project else { return }
        projectLibraryViewController.viewModel.appendProject(with: project)
    }
    
    func publish(completion: ((Error?) -> Void)?) {
        guard let project = project else {
            return
        }
        apiCommunicator.publish(project: project) { (error) in
            completion?(error)
        }
    }
    
}
