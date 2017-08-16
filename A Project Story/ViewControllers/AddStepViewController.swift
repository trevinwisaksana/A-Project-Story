//
//  AddStepViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class AddStepViewController: UIViewController {
    
    fileprivate let mainView = AddStepMainView()
    let viewModel = AddStepViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case didPressCancelButton
        case addingStep(Step)
        case didPressAddButton
        case failedToCreateStep(as: Error)
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
            setCancelButtonTarget()
            setAddStepButtonTarget()
            prepareTextViewDelegate()
            prepareTextFieldDelegates()
        case .didPressAddButton:
            addStep()
        case .addingStep(let step):
            passDataToPresenterViewController(data: step)
        case .didPressCancelButton:
            dismiss(animated: true, completion: nil)
        case .failedToCreateStep(let error):
            throwWarning(for: error)
        default:
            break
        }
    }
    
    // MARK: - Error Handler
    fileprivate enum `Error` {
        case stepTitleIsEmpty
    }
    
    private func throwWarning(for error: Error) {
        switch error {
        case .stepTitleIsEmpty:
            mainView.displayStepTitleAlert()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        state = .viewDidLayoutSubviews
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setCancelButtonTarget() {
        mainView.cancelButton.addTarget(self, action: #selector(didPressCancelButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressCancelButton() {
        state = .didPressCancelButton
    }
    
    private func setAddStepButtonTarget() {
        mainView.addStepButton.addTarget(self, action: #selector(didPressAddStepButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressAddStepButton() {
        state = .didPressAddButton
    }
    
    private func passDataToPresenterViewController(data: Step) {
        if let presenter = presentingViewController as? DraftViewController {
            presenter.viewModel.appendStep(with: data)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func addStep() {
        
        let stepName = mainView.stepTitleTextField.text ?? ""
        var stepDescription = mainView.stepDescriptionTextView.text ?? ""
        
        viewModel.addStep(title: stepName, description: &stepDescription, completion: { [weak self] (error, data) in
            
            switch error {
            case nil:
                if let data = data {
                    self?.state = .addingStep(data)
                }
            default:
                self?.translateErrorMessage(error!)
            }
        })
    }
    
    // TODO: Create a universal error state
    private func translateErrorMessage(_ error: NSError) {
        switch error.domain {
        case "titleIsEmpty":
            state = .failedToCreateStep(as: .stepTitleIsEmpty)
        default:
            break
        }
    }
    
}


extension AddStepViewController: UITextFieldDelegate {
    
    fileprivate func prepareTextFieldDelegates() {
        mainView.stepTitleTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        textField.textColor = .black
        textField.alpha = 1
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension AddStepViewController: UITextViewDelegate {
    
    fileprivate func prepareTextViewDelegate() {
        mainView.stepDescriptionTextView.delegate = self
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
            textView.text = "Enter your step description here..."
            textView.textColor = .lightGray
        }
        // Hides the keyboard
        textView.resignFirstResponder()
    }
}
