//
//  ProjectLibraryViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/5/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

/////////////////////////////////////
// Project Library View Controller //
/////////////////////////////////////

final class ProjectLibraryViewController: UIViewController {
    
    private var mainView = ProjectLibraryMainView()
    let viewModel = ProjectLibraryViewModel()
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case viewDidAppear
        case addProject
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
            setAddProjectButtonTarget()
            registerCollectionViewHeader()
            registerCollectionViewCell()
            setCollectionViewDataSource()
        case .viewDidAppear:
            break
        case .addProject:
            presentAddProjectViewController()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        state = .viewDidAppear
    }
    
    // Miscellaneaous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Methods
    private func setAddProjectButtonTarget() {
        mainView.addProjectButton.addTarget(self, action: #selector(didPressAddProjectButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressAddProjectButton() {
        state = .addProject
    }
    
    private func setCollectionViewDataSource() {
        mainView.projectLibraryCollectionView.delegate = self
        mainView.projectLibraryCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        mainView.projectLibraryCollectionView.register(
            ProjectLibraryCollectionViewCell.self,
            forCellWithReuseIdentifier: "ProjectLibraryCell"
        )
    }
    
    private func registerCollectionViewHeader() {
        mainView.projectLibraryCollectionView.register(ProjectLibraryReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProjectLibraryCollectionViewHeader")
    }
    
    private func presentAddProjectViewController() {
        present(CreateProjectViewController(), animated: true, completion: nil)
    }
}


///////////////////////////////
// Collection View Extension //
///////////////////////////////

extension ProjectLibraryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectLibraryCell", for: indexPath) as! ProjectLibraryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProjectLibraryCollectionViewHeader", for: indexPath) as! ProjectLibraryReusableView
            return reusableView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width
        let height = self.view.frame.height * 0.5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = self.view.frame.width
        let height = self.view.frame.height * 0.1
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
