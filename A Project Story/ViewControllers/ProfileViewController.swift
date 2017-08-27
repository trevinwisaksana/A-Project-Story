//
//  ProfileViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController, PublishProjectDelegate {
    
    private let mainView = ProfileMainView()
    let viewModel = ProfileViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case viewWillAppear
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
            retrievePublishedProjects()
        case .viewDidLayoutSubviews:
            mainView.registerCollectionViewCells()
            setCollectionViewDataSource()
        case .viewWillAppear:
            break
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        state = .viewWillAppear
    }
    
    private func setCollectionViewDataSource() {
        mainView.profileCollectionView?.delegate = self
        mainView.profileCollectionView?.dataSource = self
        mainView.profileCollectionView?.reloadData()
    }
    
    private func retrievePublishedProjects() {
        mainView.displayLoadingIndicator()
        viewModel.retrievePublishedProjects { (error) in
            self.mainView.profileCollectionView?.reloadData()
            self.mainView.dismissLoadingIndicator()
        }
    }
    
}


extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width * 0.4
        let height = view.frame.height * 0.3
        let cellSize = CGSize(width: width, height: height)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        default:
            assert(false, "Section out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        default:
            assert(false, "Section out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        default:
            assert(false, "Section out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
