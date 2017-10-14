//
//  SearchViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/27/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class SearchViewModel {
    
    var listOfSearchedProjects: [Project] = []
    let apiCommunicator = APICommunicator()
    
    func append(_ project: Project) {
        listOfSearchedProjects.append(project)
    }
    
    func removeSearchedProjects() {
        listOfSearchedProjects.removeAll()
    }
    
    func numberOfItems() -> Int {
        return listOfSearchedProjects.count
    }
    
    func retreiveSearchedProject(with title: String, completion: ((Error?) -> Void)?) {
        self.listOfSearchedProjects.removeAll()
        apiCommunicator.retrieveSearchedProject(with: title) { (project) in
            guard let project = project else {
                let error = NSError(domain: "Project not found", code: 404, userInfo: nil)
                completion?(error)
                return
            }
            self.listOfSearchedProjects.append(project)
            completion?(nil)
        }
    }
    
}
