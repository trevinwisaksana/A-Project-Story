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
import Firebase
import SwiftyJSON

final class Project {
    var title: String
    let ownerEmail: String
    var description: String
    var steps: [Step] = []
    
    init(title: String, ownerEmail: String, description: String) {
        self.title = title
        self.ownerEmail = ownerEmail
        self.description = description
    }
    
    init?(snapshot: FIRDataSnapshot) {
        
        let snapshot = JSON(snapshot.value)
        
        guard let title = snapshot["title"].string else {
            return nil
        }
        
        let ownerEmail = snapshot["ownerEmail"].string ?? ""
        let description = snapshot["description"].string ?? ""
        
        
        
        self.title = title
        self.ownerEmail = ownerEmail
        self.description = description
        
        if let stepsData = snapshot["steps"].arrayObject as? [Step] {
            self.steps.append(contentsOf: stepsData)
        }
    }
}

extension Project {
    
    func encodeOwner(email: String) -> String {
        return email.replacingOccurrences(of: ".", with: ",")
    }
    
    func decodeOwner(email: String) -> String {
        return email.replacingOccurrences(of: ",", with: ".")
    }
    
    func stepsToJSON(_ steps: [Step]) -> [[String : String]] {
        let json = steps.map { (step) -> [String : String] in
            return step.toJSON()
        }
        return json
    }
    
    func toJSON() -> [String : Any] {
        return ["title": title,
                "description": description,
                "steps": stepsToJSON(steps)]
    }
}
