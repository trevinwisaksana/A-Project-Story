//
//  SearchViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    let mainView = SearchMainView()
    let viewModel = SearchViewModel()
    
    fileprivate enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case didPressDoneButton(title: String)
        case willEmptySearchProjects
    }
    
    fileprivate var state: State = .default {
        didSet {
            didChange(state)
        }
    }
    
    private func didChange(_ state: State) {
        switch state {
        case .loading:
            view = mainView
        case .viewDidLayoutSubviews:
            mainView.registerCollectionViewCell()
            setCollectionViewDataSource()
            setTextFieldDelegate()
        case .didPressDoneButton(let title):
            retrieveSearchedProject(with: title)
        case .willEmptySearchProjects:
            removeSearchedProjects()
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
    
    private func setCollectionViewDataSource() {
        mainView.searchedProjectCollectionView?.dataSource = self
        mainView.searchedProjectCollectionView?.delegate = self
    }
    
    private func retrieveSearchedProject(with title: String) {
        mainView.displayLoadingIndicator()
        viewModel.retreiveSearchedProject(with: title) { (error) in
            if error == nil {
                self.mainView.searchedProjectCollectionView?.reloadData()
                self.mainView.dismissLoadingIndicator()
            } else {
                // TODO: Error handling
                self.mainView.dismissLoadingIndicator()
            }
            
        }
    }
    
    private func removeSearchedProjects() {
        viewModel.removeSearchedProjects()
        mainView.searchedProjectCollectionView?.reloadData()
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchedProjectCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    fileprivate func setTextFieldDelegate() {
        mainView.searchTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        textField.textColor = .black
        textField.alpha = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let searchTextField = textField.text ?? ""
        if searchTextField.isEmpty {
            textField.placeholder = "Search"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text == "" {
            state = .willEmptySearchProjects
        } else {
            state = .didPressDoneButton(title: textField.text ?? "")
        }
        return true
    }
    
}
