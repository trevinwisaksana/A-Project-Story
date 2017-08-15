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
        viewModel.assignProject(data: project)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate enum State {
        case `default`
        case loading
        case viewDidLayoutSubviews
        case viewDidAppear
        case didBecomeActive
        case didPressBackButton
        case didPressAddStepButton
        case didPressNextButton(passing: Project)
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
        case .viewDidLayoutSubviews:
            setBackButtonTarget()
            setNextButtonTarget()
            mainView.registerCollectionViewCell()
            mainView.registerCollectionViewHeader()
            setCollectionViewDelegate()
            addCollectionViewLongPressGestureRecognizer()
            assignProjectTitle()
        case .viewDidAppear, .didBecomeActive:
            setAddStepButtonTarget()
        case .didPressBackButton:
            dismiss(animated: true, completion: nil)
        case .didPressAddStepButton:
            presentAddStepViewController()
        case .didPressNextButton(let project):
            presentPublishProjectViewController(with: project)
        case .didSelectCell(let indexPath):
            let stepData = viewModel.didSelectItemAt(indexPath: indexPath)
            guard let step = stepData else { return }
            presentStepViewController(with: step)
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
    
    @objc
    private func didBecomeActive() {
        state = .didBecomeActive
    }
    
    // Miscellaneous
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setViewDidBecomeActiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    private func setBackButtonTarget() {
        mainView.backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressBackButton() {
        state = .didPressBackButton
    }
    
    // MARK: - Methods
    private func setCollectionViewDelegate() {
        mainView.stepCollectionView.delegate = self
        mainView.stepCollectionView.dataSource = self
        mainView.stepCollectionView.reloadData()
    }
    
    private func setNextButtonTarget() {
        mainView.nextButton.addTarget(self, action: #selector(didPressNextButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressNextButton() {
        guard let project = viewModel.passProjectData() else { return }
        state = .didPressNextButton(passing: project)
    }
    
    private func setAddStepButtonTarget() {
        let sectionHeader = mainView.stepCollectionView.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader)[0] as! StepCollectionViewHeader
        sectionHeader.addStepButton.addTarget(self, action: #selector(didPressAddStepButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressAddStepButton() {
        state = .didPressAddStepButton
    }
    
    private func addCollectionViewLongPressGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGestureHandler(gesture:)))
        mainView.stepCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func longGestureHandler(gesture: UILongPressGestureRecognizer) {
        // Step Collection View
        let collectionView = mainView.stepCollectionView
        
        switch gesture.state {
        case .began:
            let gestureLocation = gesture.location(in: collectionView)
            guard let selectedIndexPath = collectionView?.indexPathForItem(at: gestureLocation) else {
                break
            }
            collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            let gestureLocation = gesture.location(in: gesture.view)
            collectionView?.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionView?.endInteractiveMovement()
        default:
            mainView.stepCollectionView.cancelInteractiveMovement()
        }
    }
    
    private func presentAddStepViewController() {
        present(AddStepViewController(), animated: true, completion: nil)
    }
    
    private func presentPublishProjectViewController(with data: Project) {
        let targetViewController = PublishProjectViewController(project: data)
        present(targetViewController, animated: true, completion: nil)
    }
    
    private func presentStepViewController(with data: Step) {
        present(StepViewController(step: data), animated: true, completion: nil)
    }
    
    private func assignProjectTitle() {
        let projectTitle = viewModel.projectTitle()
        mainView.assignProjectTitle(with: projectTitle)
    } 
}


extension DraftViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCell", for: indexPath) as! StepCell
        guard let step = viewModel.passStep(at: indexPath) else {
            assert(false, "Data unavailable")
        }
        step.index = indexPath.row + 1
        cell.configure(with: step)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.88
        let height = collectionView.frame.height * 0.15
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        state = .didSelectCell(at: indexPath)
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
            let width = collectionView.frame.width
            let height = self.view.frame.height * 0.07
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 10
        default:
            return 0
        }
    }
}
