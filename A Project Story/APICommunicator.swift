//
//  APICommunicator.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth
import SwiftyJSON

protocol APICommunicationProcotol {
    func createProject(draft: Project, completion: ((Error) -> Void)?)
    func createStep(_ step: Step, completion: ((Error) -> Void)?)
    func updateProjectDraft()
    func deleteProjectDraft()
    func createPublishedProject()
}

final class APICommunicator: APICommunicationProcotol {
    
    private let database = FIRDatabase.database().reference()
    private let firebaseAuth = FIRAuth.auth()
    private let uid = FIRAuth.auth()?.currentUser?.uid
    private let usersReference = FIRDatabase.database().reference().child("users")
    private let projectsReference = FIRDatabase.database().reference().child("projects")
    
    // MARK: - App Entry And Exit
    public func signIn(with email: String, password: String, completion: ((Error?) -> Void)?) {
        firebaseAuth?.signIn(withEmail: email, password: password,
                             completion: { (user, error) in
            completion?(error)
        })
    }
    
    public func signOut() {
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    public func signUp(with email: String, password: String, completion: ((Error?) -> Void)?) {
        // TODO: Check if this is an asynchronous call
        // Success in signing up, create user in Firebase
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            // There's no error
            if error == nil {
                
                guard let user = user else {
                    return
                }
                
                let userReference = self.database.child("users").child(user.uid)
                
                // Create Firebase path for this user and save email
                let emailDictionary = ["email": "\(email)"]
                
                // BUG: Format of the completion block must be correct
                // because there is a bug in Firebase
                userReference.setValue(emailDictionary) { (error, _) in
                    completion?(nil)
                }
            } else {
                // Passes the error
                completion?(error)
            }
        })
        
    }
    
    func createProject(draft: Project, completion: ((Error) -> Void)?) {
        let jsonData = draft.toJSON()
        
        guard let uid = uid else { return }
        
        usersReference.child(uid).child("draft").setValue(jsonData) { (error, reference) in
            if let error = error {
                completion?(error)
            }
        }
    }
    
    func publish(project: Project, completion:((Error?) -> Void)?) {
        
        
        let jsonData = project.toJSON()
        
        guard let uid = uid else {
            return
        }
        
        usersReference.child(uid).child("project").setValue(jsonData) { (error, reference) in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
        
        projectsReference.setValue(jsonData) { (error, reference) in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
        
    }
    
    func retrieveProjects(completion: (([Project]?, Error?) -> Void)?) {
        var projects: [Project] = []
        
        guard let uid = uid else { return }
        
        usersReference.child(uid).child("project").observe(.value, with: { (snapshot) in
            guard let project = Project(snapshot: snapshot) else { return }
            projects.append(project)
            completion?(projects, nil)
        }) { (error) in
            completion?(nil, error)
        }
    }
    
    func createStep(_ step: Step, completion: ((Error) -> Void)?) {
        let jsonData = step.toJSON()
        database.child("Projects").child("test@testing,com").child("steps").setValue(jsonData) { (error, reference) in
            if let error = error {
                completion?(error)
            }
        }
    }
    
    func updateProjectDraft() {
        
    }
    
    func deleteProjectDraft() {
        
    }
    
    func createPublishedProject() {
        
    }
    
    
}
