//
//  ProjectDataModel.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

////////////////
// Project Model //
////////////////

final class Project {
    var title: String
    let ownerEmail: String
    var description: String
    
    init(title: String, ownerEmail: String, description: String) {
        self.title = title
        self.ownerEmail = ownerEmail
        self.description = description
    }
}
