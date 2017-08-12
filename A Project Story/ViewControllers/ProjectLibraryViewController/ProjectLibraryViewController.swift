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
    
    fileprivate var mainView = ProjectLibraryMainView()
    let viewModel = ProjectLibraryViewModel()
    
    fileprivate enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case viewDidAppear
        case didBecomeActive
        case didPressAddProjectButton
        case didPressShowMoreButton
        case didSelectCell(at: IndexPath)
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
            
            setViewDidBecomeActiveNotification()
            
            /////////////
            // Testing //
            /////////////
            let project = Project(title: "Testing", ownerEmail: "testing", description: "Hello, this is a new project.")
            viewModel.appendDraft(with: project)
            viewModel.appendDraft(with: project)
            viewModel.appendProject(with: project)
            viewModel.appendProject(with: project)
            
        case .viewDidLayoutSubviews:
            setAddProjectButtonTarget()
            registerCollectionViewHeader()
            registerCollectionViewFooter()
            registerCollectionViewCells()
            setCollectionViewDelegate()
        case .viewDidAppear:
            setShowMoreButtonTarget()
        case .didBecomeActive:
            break
        case .didPressAddProjectButton:
            presentAddProjectViewController()
        case .didSelectCell(let indexPath):
            let project = viewModel.didSelectItemAt(indexPath: indexPath)
            determineViewControllerToPresent(with: indexPath, data: project)
        case .didPressShowMoreButton:
            minimizeOrExpandDraftSection()
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
    
    @objc
    private func didBecomeActive() {
        state = .didBecomeActive
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
        state = .didPressAddProjectButton
    }
    
    private func setCollectionViewDelegate() {
        mainView.projectLibraryCollectionView.delegate = self
        mainView.projectLibraryCollectionView.dataSource = self
        mainView.projectLibraryCollectionView.reloadData()
    }
    
    private func setViewDidBecomeActiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    private func registerCollectionViewCells() {
        mainView.projectLibraryCollectionView.register(
            FeaturedCollectionViewCell.self,
            forCellWithReuseIdentifier: "FeaturedCell"
        )
        mainView.projectLibraryCollectionView.register(
            DraftCollectionViewCell.self,
            forCellWithReuseIdentifier: "DraftCell"
        )
    }
    
    private func registerCollectionViewHeader() {
        mainView.projectLibraryCollectionView.register(FeaturedCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FeaturedCollectionViewHeader")
        mainView.projectLibraryCollectionView.register(DraftCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DraftCollectionViewHeader")
    }
    
    private func registerCollectionViewFooter() {
        mainView.projectLibraryCollectionView.register(DraftCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DraftCollectionViewFooter")
    }
    
    private func setShowMoreButtonTarget() {
        let collectionView = mainView.projectLibraryCollectionView
        let numberOfDrafts = viewModel.numberOfItemsIn(section: 0)
        
        if numberOfDrafts > 0 {
            let sectionFooter = collectionView?.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionFooter)[0] as! DraftCollectionViewFooter
            let showMoreButton = sectionFooter.showMoreButton
            showMoreButton.addTarget(self, action: #selector(didPressShowMoreButton), for: .touchUpInside)
        }
    }
    
    @objc
    private func didPressShowMoreButton() {
        state = .didPressShowMoreButton
    }
    
    private func minimizeOrExpandDraftSection() {
        if viewModel.didEnlargeDraftSection {
            viewModel.showLessDrafts()
        } else {
            viewModel.showMoreDrafts()
        }
        mainView.projectLibraryCollectionView.reloadData()
    }
    
    private func presentAddProjectViewController() {
        present(CreateProjectViewController(), animated: true, completion: nil)
    }
    
    private func determineViewControllerToPresent(with indexPath: IndexPath, data: Project) {
        let section = indexPath.section
        switch section {
        case 0:
            present(DraftViewController(project: data), animated: true, completion: nil)
        case 1:
            present(ProjectViewController(project: data), animated: true, completion: nil)
        default:
            break
        }
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DraftCell", for: indexPath) as! DraftCollectionViewCell
            cell.configure(with: viewModel, forRowAtIndexPath: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! FeaturedCollectionViewCell
            return cell
        default:
            assert(false, "Section out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let section = indexPath.section
        let numberOfDrafts = viewModel.numberOfItemsIn(section: 0)
        let numberOfProjects = viewModel.numberOfItemsIn(section: 1)
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            var listOfSectionTitle = [String]()
        
            switch section {
            case 0:
                
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DraftCollectionViewHeader", for: indexPath) as! DraftCollectionViewHeader
                let sectionTitleLabel = reusableView.sectionTitleLabel
                
                if numberOfDrafts > 0 {
                    listOfSectionTitle.append("Drafts")
                } else {
                    listOfSectionTitle.append("")
                }
                
                sectionTitleLabel.text = listOfSectionTitle[0]
                return reusableView
                
            case 1:
                
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FeaturedCollectionViewHeader", for: indexPath) as! FeaturedCollectionViewHeader
                let sectionTitleLabel = reusableView.sectionTitleLabel
                
                if numberOfProjects > 0 {
                    listOfSectionTitle.append("Featured")
                } else {
                    listOfSectionTitle.append("")
                }
                
                sectionTitleLabel.text = listOfSectionTitle[0]
                return reusableView
                
            default:
                assert(false, "Section out of range")
            }
            
        case UICollectionElementKindSectionFooter:
            switch section {
            case 0:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "DraftCollectionViewFooter", for: indexPath) as! DraftCollectionViewFooter
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
            
            if viewModel.numberOfItemsIn(section: section) == 0 {
                return CGSize.zero
            }
            
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.07
            return CGSize(width: width, height: height)
            
        case 1:
            
            if viewModel.numberOfItemsIn(section: section) == 0 {
                return CGSize.zero
            }
            
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.1
            return CGSize(width: width, height: height)
            
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 0:
            let numberOfDrafts = viewModel.numberOfItemsIn(section: section)
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.03
            
            if numberOfDrafts == 0 {
                return CGSize.zero
            } else {
                return CGSize(width: width, height: height)
            }
    
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
        case 1:
            return 20
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // If the list of drafts is empty
        // remove buffer space on top
        if viewModel.numberOfItemsIn(section: 0) == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        state = .didSelectCell(at: indexPath)
    }
}
