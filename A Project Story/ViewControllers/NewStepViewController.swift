//
//  NewStepViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class NewStepViewController: UIViewController {
    
    private let mainView = NewStepMainView()
    let viewModel = NewStepViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case cancelAdd
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
        case .cancelAdd:
            dismiss(animated: true, completion: nil)
        default:
            break
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
        state = .cancelAdd
    }
    
    
}
