//
//  SignInViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    
    private let mainView = SignInMainView()
    let viewModel = SignInViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case didPressLogInButton
        case didPressSignUpButton
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
            addLogInButtonTarget()
            addSignUpButtonTarget()
        case .didPressLogInButton:
            signInUser()
        case .didPressSignUpButton:
            transitionToSignUpViewController()
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
    
    private func addLogInButtonTarget() {
        mainView.logInButton.addTarget(self, action: #selector(didPressLogInButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressLogInButton() {
        state = .didPressLogInButton
    }
    
    private func addSignUpButtonTarget() {
        mainView.signUpButton.addTarget(self, action: #selector(didPressSignUpButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressSignUpButton() {
        state = .didPressSignUpButton
    }
    
    private func switchRootViewController() {
        // Accessing the App Delegate
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        // Present the next view controller
        appDelegate?.window?.rootViewController = TabBarViewController()
    }
    
    private func transitionToSignUpViewController() {
        present(SignUpViewController(), animated: true, completion: nil)
    }
    
    private func signInUser() {
        guard let email = mainView.emailAddressTextField.text else { return }
        guard let password = mainView.passwordTextField.text else { return }
        viewModel.signIn(email: email, password: password) { (error) in
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
