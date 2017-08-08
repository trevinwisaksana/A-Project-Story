//
//  DraftViewController.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class DraftViewController: UIViewController {
    
    private let mainView = DraftMainView()
    let viewModel = DraftViewModel()
    
    init(project: Project) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case viewDidAppear
        case backButtonPressed
        case addStepButtonPressed
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
            registerCollectionViewCell()
            registerCollectionViewHeader()
            setCollectionViewDelegate()
        case .viewDidAppear:
            setAddStepButtonTarget()
        case .backButtonPressed:
            dismiss(animated: true, completion: nil)
        case .addStepButtonPressed:
            presentNewStepViewController()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        state = .viewDidAppear
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setBackButtonTarget() {
        mainView.backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressBackButton() {
        state = .backButtonPressed
    }
    
    // MARK: - Methods
    private func setCollectionViewDelegate() {
        mainView.stepCollectionView.delegate = self
        mainView.stepCollectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        mainView.stepCollectionView.register(StepCell.self, forCellWithReuseIdentifier: "StepCell")
    }
    
    private func registerCollectionViewHeader() {
        mainView.stepCollectionView.register(StepCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "StepCollectionViewHeader")
    }
    
    private func setAddStepButtonTarget() {
        let sectionHeader = mainView.stepCollectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader)[0] as! StepCollectionViewHeader
        sectionHeader.addStepButton.addTarget(self, action: #selector(didPressAddStepButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressAddStepButton() {
        state = .addStepButtonPressed
    }
    
    private func presentNewStepViewController() {
        present(NewStepViewController(), animated: true, completion: nil)
    }
    
}


extension DraftViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCell", for: indexPath) as! StepCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let section = indexPath.section
            
            switch section {
            case 0:
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "StepCollectionViewHeader", for: indexPath) as! StepCollectionViewHeader
                
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
            let width = self.view.frame.width
            let height = self.view.frame.height * 0.07
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
