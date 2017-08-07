//
//  CreateProjectViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

////////////////////////////////////
// Create Project View Controller //
////////////////////////////////////

final class CreateProjectViewController: UIViewController {
    
    fileprivate let mainView = CreateProjectMainView()
    
    private enum State {
        case `default`
        case loading
        case viewDidAppear
        case cancelToAdd
        case createProject
        case failedToCreateProject(as: Error)
    }
    
    private enum `Error` {
        case projectNameAndEmailIsEmpty
        case projectNameIsEmpty
        case emailAddressIsEmpty
    }
    
    private var state: State = .default {
        didSet {
            didChange(state)
        }
    }
    
    private func didChange(_ state: State) {
        switch state {
        case .loading:
            self.view = mainView
        case .viewDidAppear:
            setCancelToCreateButtonTarget()
            setCreateProjectButtonTarget()
            prepareTextFieldDelegates()
            prepareTextViewDelegate()
        case .cancelToAdd, .createProject:
            dismiss(animated: true, completion: nil)
        case .failedToCreateProject(let error):
            throwWarning(for: error)
        default:
            break
        }
    }
    
    private func throwWarning(for error: Error) {
        switch error {
        case .projectNameAndEmailIsEmpty:
            mainView.displayProjectNameAlert()
            mainView.displayEmailAddressAlert()
        case .projectNameIsEmpty:
            mainView.displayProjectNameAlert()
        case .emailAddressIsEmpty:
            mainView.displayEmailAddressAlert()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        state = .viewDidAppear
    }
    
    // Miscellaneaous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Methods
    private func setCancelToCreateButtonTarget() {
        mainView.cancelToCreateButton.addTarget(self, action: #selector(didPressCancelToCreateButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressCancelToCreateButton() {
        state = .cancelToAdd
    }
    
    private func setCreateProjectButtonTarget() {
        mainView.createProjectButton.addTarget(self, action: #selector(didPressCreateProjectButton), for: .touchUpInside)
    }
    
    private func createProjectInformationIsComplete() -> Bool {
        
        let projectName = mainView.projectNameTextField.text ?? ""
        let emailAddress = mainView.emailAddressTextField.text ?? ""
        
        if projectName.isEmpty && emailAddress.isEmpty {
            state = .failedToCreateProject(as: .projectNameAndEmailIsEmpty)
            return false
        } else if projectName.isEmpty {
            state = .failedToCreateProject(as: .projectNameIsEmpty)
            return false
        } else if emailAddress.isEmpty {
            state = .failedToCreateProject(as: .emailAddressIsEmpty)
            return false
        }
        
        return true
    }
    
    @objc
    private func didPressCreateProjectButton() {
        if createProjectInformationIsComplete() {
            state = .createProject
        }
    }
    
}


extension CreateProjectViewController: UITextFieldDelegate {
    
    fileprivate func prepareTextFieldDelegates() {
        mainView.projectNameTextField.delegate = self
        mainView.emailAddressTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        textField.textColor = .black
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let projectNameTextField = mainView.projectNameTextField
        let emailAddressTextField = mainView.emailAddressTextField
        
        if textField.isEqual(projectNameTextField) {
            textField.placeholder = "New Project Name"
        }
        
        if textField.isEqual(emailAddressTextField) {
            textField.placeholder = "Enter your email address..."
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateProjectViewController: UITextViewDelegate {
    
    fileprivate func prepareTextViewDelegate() {
        mainView.projectDescriptionTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // Check if the textView is empty to add placeholder
        if textView.text.isEmpty {
            textView.text = "Enter your project description here..."
            textView.textColor = .lightGray
        }
        // Hides the keyboard
        textView.resignFirstResponder()
    }
}
