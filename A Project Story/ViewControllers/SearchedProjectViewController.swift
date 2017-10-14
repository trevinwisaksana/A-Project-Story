//
//  SearchedProjectViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/28/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class SearchedProjectViewController: UIViewController {
    
    let viewModel = SearchedProjectViewModel()
    let mainView = SearchedProjectMainView()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
    }
    
    private var state: State = .default {
        didSet {
            didChange(state)
        }
    }
    
    private func didChange(_ state: State) {
        switch state {
        case .loading:
            break
        case .viewDidLayoutSubviews:
            break
        default:
            view = mainView
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
    
}
