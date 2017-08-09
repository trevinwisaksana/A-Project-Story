//
//  PublishProjectViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class PublishProjectViewController: UIViewController {
    
    private let mainView = PublishProjectMainView()
    let viewModel = PublishProjectViewModel()
    
    private enum State {
        case `default`
        case loading
        case backButonPressed
        case publishButtonPressed
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
        
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
