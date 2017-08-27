//
//  ProfileViewModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import Foundation

final class ProfileViewModel {
    
    private var listOfPublishedProjects = [Project]()
    let apiCommunicator = APICommunicator()
    var cellIndexSelected: Int?
  
    func appendPublishedProject(with data: Project) {
        listOfPublishedProjects.append(data)
    }
    
    func removePublishedProject(at index: Int) {
        listOfPublishedProjects.remove(at: index)
    }
    
    func listOfPublishedProjectsCount() -> Int {
        return listOfPublishedProjects.count
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        switch section {
        case 0:
            return listOfPublishedProjects.count
        default:
            assert(false, "Section out of bounds")
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) -> Project {
        let section = indexPath.section
        switch section {
        case 0:
            return listOfPublishedProjects[indexPath.row]
        default:
            assert(false, "Section out of bounds")
        }
    }
    
    func retrievePublishedProjects(completion: ((Error?) -> Void)?) {
        apiCommunicator.retrieveProjects { (listOfProjects, error) in
            if let error = error {
                completion?(error)
            } else {
                guard let projects = listOfProjects else { return }
                self.listOfPublishedProjects.append(contentsOf: projects)
                completion?(nil)
            }
        }
    }
    
}
