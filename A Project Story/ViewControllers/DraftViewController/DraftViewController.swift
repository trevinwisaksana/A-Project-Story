//
//  DraftViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class DraftViewController: UIViewController {
    
    private let mainView = DraftMainView()
    let viewModel = DraftViewModel()
    
    init(project: Project) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case backButtonPressed
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
        case .backButtonPressed:
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
    
    private func setBackButtonTarget() {
        mainView.backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressBackButton() {
        state = .backButtonPressed
    }
    
}
