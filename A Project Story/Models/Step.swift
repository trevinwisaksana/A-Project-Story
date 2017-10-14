//
//  Step.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/9/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import RealmSwift
import Realm

final class Step {
    
    var title: String
    var description: String
    var index = 0
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

}

extension Step {
    func toJSON() -> [String: String] {
        return ["title": title, "description": description]
    }
}
