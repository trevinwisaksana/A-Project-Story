//
//  PublishProjectViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

protocol PublishProjectDelegate {
    // func removeProjectDraft(at: Int)
}

final class PublishProjectViewController: UIViewController {
    
    fileprivate let mainView = PublishProjectMainView()
    let viewModel = PublishProjectViewModel()
    
    init(project: Project) {
        super.init(nibName: nil, bundle: nil)
        viewModel.assignProject(data: project)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case didPressBackButton
        case didPressPublishButton
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
        case .viewDidLayoutSubviews:
            setBackButtonTarget()
            setPublishButtonTarget()
            mainView.registerCollectionViewCells()
            mainView.registerCollectionViewSections()
            setCollectionViewDelegate()
        case .didPressBackButton:
            dismiss(animated: true, completion: nil)
        case .didPressPublishButton:
            publishProject()
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
    
    private func setBackButtonTarget() {
        mainView.backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressBackButton() {
        state = .didPressBackButton
    }
    
    private func setPublishButtonTarget() {
        mainView.publishButton.addTarget(self, action: #selector(didPressPublishButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressPublishButton() {
        state = .didPressPublishButton
    }
    
    private func setCollectionViewDelegate() {
        mainView.publishCollectionView.delegate = self
        mainView.publishCollectionView.dataSource = self
        mainView.publishCollectionView.reloadData()
    }
    
    private func publishProject() {
        mainView.displayLoadingIndicator()
        viewModel.publish { (error) in
            if let error = error {
                self.mainView.dismissLoadingIndicator()
            } else {
                self.mainView.dismissLoadingIndicator()
                self.dismissModalStack()
            }
        }
    }
    
    private func dismissModalStack() {
        var viewController = presentingViewController
        repeat {
            viewController = viewController?.presentingViewController
        } while viewController?.presentingViewController != nil
        
        viewController?.dismiss(animated: true, completion: nil)
        
        guard let projectLibraryViewController = viewController?.childViewControllers.first as? ProjectLibraryViewController else { return
        }
        viewModel.removeProjectDraft(from: projectLibraryViewController)
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


extension PublishProjectViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtworkCell", for: indexPath) as! ArtworkCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDescriptionCell", for: indexPath) as! ProjectDescriptionCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepsCell", for: indexPath) as! StepsCell
            return cell
        default:
            assert(false, "Section out of range")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.88
        let height = collectionView.frame.height * 0.1
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        state = .didSelectCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let project = viewModel.passProjectData() else {
            assert(false, "Project data is nil")
        }
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let section = indexPath.section
            switch section {
            case 0:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ArtworkSection", for: indexPath) as! ArtworkSection
                reusableView.configure(with: project)
                return reusableView
            case 1:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProjectDescriptionSection", for: indexPath) as! ProjectDescriptionSection
                reusableView.configure(with: project)
                reusableView.projectDescriptionTextView.delegate = self
                return reusableView
            case 2:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "StepsSection", for: indexPath) as! StepSection
                reusableView.configure(with: project)
                return reusableView
            default:
                assert(false, "Section out of range")
            }
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            let width = collectionView.frame.width
            let height = self.view.frame.height * 0.7
            return CGSize(width: width, height: height)
        case 1:
            let width = collectionView.frame.width
            let height = self.view.frame.height * 0.3
            return CGSize(width: width, height: height)
        case 2:
            let width = collectionView.frame.width
            let height = self.view.frame.height * 0.7
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 0
        }
    }
}


extension PublishProjectViewController: UITextViewDelegate {
    
    fileprivate func prepareTextViewDelegate() {
        mainView.descriptionTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // Check if the textView is empty to add placeholder
        if textView.text.isEmpty {
            textView.text = "Please enter your project description here..."
            textView.textColor = .lightGray
        }
        // Hides the keyboard
        textView.resignFirstResponder()
    }
}
