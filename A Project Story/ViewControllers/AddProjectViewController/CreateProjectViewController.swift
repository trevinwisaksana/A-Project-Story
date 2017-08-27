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
    let viewModel = CreateProjectViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidAppear
        case didPressCancelButton
        case didPressCreateButton
        case createProject(with: Project)
        case failedToCreateProject(as: CreateProjectError)
    }
    
    private enum CreateProjectError: Error {
        case projectTitleAndEmailIsEmpty
        case projectTitleIsEmpty
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
        case .didPressCancelButton:
            dismiss(animated: true, completion: nil)
        case .didPressCreateButton:
            createProjectDraft()
        case .createProject(let data):
            passDataToPresenterViewController(data: data)
        case .failedToCreateProject(let error):
            throwWarning(for: error)
        default:
            break
        }
    }
    
    private func throwWarning(for error: CreateProjectError) {
        switch error {
        case .projectTitleAndEmailIsEmpty:
            mainView.displayProjectTitleAlert()
            mainView.displayEmailAddressAlert()
        case .projectTitleIsEmpty:
            mainView.displayProjectTitleAlert()
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
    
    // MARK: - Methods
    private func setCancelToCreateButtonTarget() {
        mainView.cancelToCreateButton.addTarget(self, action: #selector(didPressCancelToCreateButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressCancelToCreateButton() {
        state = .didPressCancelButton
    }
    
    private func setCreateProjectButtonTarget() {
        mainView.createProjectButton.addTarget(self, action: #selector(didPressCreateProjectButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressCreateProjectButton() {
        state = .didPressCreateButton
    }
    
    private func createProjectDraft() {
        
        let projectName = mainView.projectTitleTextField.text ?? ""
        let email = mainView.emailAddressTextField.text ?? ""
        var description = mainView.projectDescriptionTextView.text ?? ""
        
        viewModel.createProject(title: projectName, email: email, description: &description, completion: { [weak self] (error, data) in
            if error == nil {
                if let data = data {
                    self?.state = .createProject(with: data)
                }
            } else {
                self?.translateErrorMessage(error!)
            } 
        })
    }
    
    private func passDataToPresenterViewController(data: Project) {
        if let presenter = presentingViewController as? TabBarViewController {
            // Insert at 0 because users can see the latest draft
            let projectLibraryViewController = presenter.childViewControllers.first as? ProjectLibraryViewController
            projectLibraryViewController?.viewModel.insertProjectDraft(at: 0, data: data)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: Create a universal error state
    private func translateErrorMessage(_ error: NSError) {
        switch error.domain {
        case "titleAndEmailIsEmpty":
            state = .failedToCreateProject(as: .projectTitleAndEmailIsEmpty)
        case "titleIsEmpty":
            state = .failedToCreateProject(as: .projectTitleIsEmpty)
        case "emailIsEmpty":
            state = .failedToCreateProject(as: .emailAddressIsEmpty)
        default:
            break
        }
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


extension CreateProjectViewController: UITextFieldDelegate {
    
    fileprivate func prepareTextFieldDelegates() {
        mainView.projectTitleTextField.delegate = self
        mainView.emailAddressTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        textField.textColor = .black
        textField.alpha = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // Take care of this in Main View
        let projectTitleTextField = mainView.projectTitleTextField
        let emailAddressTextField = mainView.emailAddressTextField
        
        if textField.isEqual(projectTitleTextField) {
            textField.placeholder = "New Project Title"
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
