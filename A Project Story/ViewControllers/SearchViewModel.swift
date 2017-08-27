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
    
    func numberOfItems() -> Int {
        return listOfSearchedProjects.count
    }
    
    func retreiveSearchedProjects() {
        apiCommunicator.retrieveProjects { (listOfProjects, error) in
            
        }
    }
    
}
