//
//  TabBarController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/5/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class TabBarViewController: UIViewController {
    
    private let mainView = TabBarMainView()
    private var listOfViewControllers = [UIViewController]()
    private var selectedIndex = 0
    
    private enum State {
        case `default`
        case loading
        case didLayoutSubviews
        case didPressProjectLibraryButton
        case didPressSearchButton
        case didPressUpdateProjectButton
        case didPressBookmarkedProjectButton
        case didPressProfileButton
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
            prepareListOfViewControllers()
        case .didLayoutSubviews:
            addTabBarButtonTargets()
            setInitialTab()
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
        state = .didLayoutSubviews
    }

    private func prepareListOfViewControllers() {
        let list: [UIViewController] = [ProjectLibraryViewController(), SearchViewController(), UpdateProjectViewController(), BookmarkedProjectsViewController(), ProfileViewController()]
        listOfViewControllers.append(contentsOf: list)
    }
    
    private func addTabBarButtonTargets() {
        mainView.projectLibraryButton.addTarget(self, action: #selector(didPressTab(_:)), for: .touchUpInside)
        mainView.searchButton.addTarget(self, action: #selector(didPressTab(_:)), for: .touchUpInside)
        mainView.updateProjectButton.addTarget(self, action: #selector(didPressTab(_:)), for: .touchUpInside)
        mainView.bookmarkedProjectsButton.addTarget(self, action: #selector(didPressTab(_:)), for: .touchUpInside)
        mainView.profileButton.addTarget(self, action: #selector(didPressTab(_:)), for: .touchUpInside)
    }
    
    private func setInitialTab() {
        let buttons = mainView.listOfButtons
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])
    }
    
    @objc
    private func didPressTab(_ button: UIButton) {
        //
        let previousIndex = selectedIndex
        selectedIndex = button.tag
        //
        mainView.listOfButtons[previousIndex].isSelected = false
        removePreviousViewController(at: previousIndex)
        button.isSelected = true
        addCurrentViewController(at: selectedIndex)
    }
    
    private func addCurrentViewController(at selectedIndex: Int) {
        let currentViewController = listOfViewControllers[selectedIndex]
        addChildViewController(currentViewController)
        currentViewController.view.frame = mainView.contentView.bounds
        mainView.contentView.addSubview(currentViewController.view)
        currentViewController.didMove(toParentViewController: self)
    }
    
    private func removePreviousViewController(at previousIndex: Int) {
        let previousViewController = listOfViewControllers[previousIndex]
        previousViewController.willMove(toParentViewController: nil)
        previousViewController.view.removeFromSuperview()
        previousViewController.removeFromParentViewController()
    }

    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
