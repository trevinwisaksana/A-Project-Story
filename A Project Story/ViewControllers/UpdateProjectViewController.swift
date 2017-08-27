//
//  UpdateProjectViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class UpdateProjectViewController: UIViewController {
    
    let mainView = UpdateProjectMainView()
    
    private enum State {
        case `default`
        case loading
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
}
