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
            registerCollectionViewSections()
            registerCollectionViewCells()
            setCollectionViewDelegate()
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
    
    private func setCollectionViewDelegate() {
        mainView.publishCollectionView.delegate = self
        mainView.publishCollectionView.dataSource = self
        mainView.publishCollectionView.reloadData()
    }
    
    private func registerCollectionViewCells() {
        mainView.publishCollectionView.register(PublishedArtworkCell.self, forCellWithReuseIdentifier: "PublishedArtworkCell")
        mainView.publishCollectionView.register(PublishedProjectDescriptionCell.self, forCellWithReuseIdentifier: "PublishedProjectDescriptionCell")
    }
    
    private func registerCollectionViewSections() {
        mainView.publishCollectionView.register(PublishedArtworkSection.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PublishedArtworkSection")
        mainView.publishCollectionView.register(PublishedProjectDescriptionSection.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PublishedProjectDescriptionSection")
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


///////////////////////////////
// Collection View Extension //
///////////////////////////////

extension ProjectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        let cell: UICollectionViewCell
        
        switch section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PublishedArtworkCell", for: indexPath) as! PublishedArtworkCell
            return cell
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedPublishedProjectDescriptionCellCell", for: indexPath) as! PublishedProjectDescriptionCell
            return cell
        default:
            assert(false, "Section out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = indexPath.section
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            switch section {
            case 0:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PublishedArtworkSection", for: indexPath) as! PublishedArtworkSection
                return reusableView
            case 1:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PublishedProjectDescriptionSection", for: indexPath) as! PublishedProjectDescriptionSection
                return reusableView
            default:
                assert(false, "Section out of range")
            }
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.07
            return CGSize(width: width, height: height)
        case 1:
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.5
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0:
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.7
            return CGSize(width: width, height: height)
        case 1:
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.3
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // state = .didSelectCell(at: indexPath)
    }
}
