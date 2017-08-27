//
//  SignUpViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    private let mainView = SignUpMainView()
    let viewModel = SignUpViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case didPressSignUpButton
        case didPressSignInButton
    }
    
    private var state: State = .default {
        didSet {
            didChange(state)
        }
    }
    
    private func didChange(_ state: State) {
        switch state {
        case .loading:
            view = mainView
        case .viewDidLayoutSubviews:
            addSignUpButtonTarget()
            addSignInButtonTarget()
        case .didPressSignUpButton:
            signUpUser()
        case .didPressSignInButton:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        state = .viewDidLayoutSubviews
    }
    
    private func switchRootViewController() {
        // Resigning keyboard
        self.resignFirstResponder()
        // Accessing the App Delegate
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        // Present the next view controller
        appDelegate?.window?.rootViewController = TabBarViewController()
    }
    
    private func addSignUpButtonTarget() {
        mainView.signUpButton.addTarget(self, action: #selector(didPressSignUpButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressSignUpButton() {
        state = .didPressSignUpButton
    }
    
    private func addSignInButtonTarget() {
        mainView.signInButton.addTarget(self, action: #selector(didPressSignInButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressSignInButton() {
        state = .didPressSignInButton
    }
    
    private func signUpUser() {
        guard let username = mainView.usernameTextField.text else {
            return
        }
        
        guard let email = mainView.emailAddressTextField.text else {
            return
        }
        
        guard let password = mainView.passwordTextField.text else {
            return
        }
        
        viewModel.signUp(with: username, email: email, password: password) { (error) in
            if let error = error {
                
            } else {
                self.switchRootViewController()
            }
        }
    }
    
    // Miscellanous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
