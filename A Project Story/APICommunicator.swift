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
    
    private let database = Database.database().reference()
    private let firebaseAuth = Auth.auth()
    private let uid = Auth.auth().currentUser?.uid
    private let usersReference = Database.database().reference().child("users")
    private let projectsReference = Database.database().reference().child("projects")
    
    // MARK: - App Entry And Exit
    public func signIn(with email: String, password: String, completion: ((Error?) -> Void)?) {
        firebaseAuth.signIn(withEmail: email, password: password,
                             completion: { (user, error) in
            completion?(error)
        })
    }
    
    public func signOut() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    public func signUp(with email: String, password: String, completion: ((Error?) -> Void)?) {
        // TODO: Check if this is an asynchronous call
        // Success in signing up, create user in Firebase
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
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
        
        usersReference.child(uid).child("project").childByAutoId().setValue(jsonData) { (error, reference) in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
        
        projectsReference.childByAutoId().setValue(jsonData) { (error, reference) in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
        
    }
    
    func retrieveProjects(completion: ((Project?, Error?) -> Void)?) {
        guard let uid = uid else { return }
        usersReference.child(uid).child("project").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren() {
                for item in snapshot.children {
                    let dataSnapshot = item as! DataSnapshot
                    guard let project = Project(snapshot: dataSnapshot) else {
                        return
                    }
                    completion?(project, nil)
                }
            } else {
                completion?(nil, nil)
            }
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
    
    func retrieveSearchedProject(with title: String, completion: ((Project?) -> Void)?) {
        
        let lowercaseText = title.lowercased()
        let query = projectsReference.queryOrdered(byChild: "searchName").queryStarting(atValue: lowercaseText).queryEnding(atValue: lowercaseText+"\u{f8ff}").queryLimited(toFirst: 10)
        
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren() {
                for item in snapshot.children {
                    guard let info = item as? DataSnapshot else {
                        break
                    }
                    guard let searchedProject = Project(snapshot: info) else {
                        return
                    }
                    completion?(searchedProject)
                }
            } else {
                completion?(nil)
            }
        })
    }
    
    func updateProjectDraft() {
        
    }
    
    func deleteProjectDraft() {
        
    }
    
    func createPublishedProject() {
        
    }
    
    
}
