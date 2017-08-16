//
//  StepViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/10/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class StepViewController: UIViewController {
    
    private let mainView = StepMainView()
    let viewModel = StepViewModel()
    
    init(step: Step) {
        super.init(nibName: nil, bundle: nil)
        viewModel.assignData(with: step)
        mainView.assignData(with: step)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case didPressBackButton
        case didPressEditButton
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
            addKeyboardFontToolbar(textView: mainView.stepDescriptionTextView)
            setBackButtonTarget()
        case .didPressBackButton:
            updateStepData()
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
    
    private func setBackButtonTarget() {
        mainView.backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressBackButton() {
        state = .didPressBackButton
    }
    
    private func updateStepData() {
        let title = mainView.stepTitleTextField.text ?? ""
        let description = mainView.stepDescriptionTextView.text ?? ""
        viewModel.updateStep(title: title, description: description) { (error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
