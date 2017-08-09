//
//  ProjectViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/5/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class ProjectViewController: UIViewController {
    
    // MARK: - Variables
    private let mainView = ProjectMainView()
    let viewModel = ProjectViewModel()
    
    // MARK: - Initializers
    init(project: Project) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - State Machine
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
            setBackButtonTarget()
        case .didPressBackButton:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    // MARK: - Life Cycle
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
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
