//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import SnapKit


// MARK: - Data Model
final class ProjectDataModel {
    var projectName: String
    let projectOwner: String
    
    init(projectName: String, projectOwner: String) {
        self.projectName = projectName
        self.projectOwner = projectOwner
    }
}

// MARK: - View Model
final class ProjectLibraryViewModel: NSObject {

    private var listOfProjects = [ProjectDataModel]()
    
    func numberOfItemsIn(section: Int) -> Int {
        return listOfProjects.count
    }
    
}

// MARK: - Main View
final class ProjectLibraryMainView: UIView {
    
    var addProjectButton: UIButton!
    var projectLibraryCollectionView: UICollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        prepareCollectionView()
        prepareAddProjectButton()
    }
    
    // Only for PDD
    private func setScreenSize() {
        let screenSize = CGSize(width: 414, height: 736)
        frame.size = screenSize
        backgroundColor = UIColor(colorLiteralRed: 248, green: 253, blue: 253, alpha: 1)
    }
    
    private func prepareCollectionView() {
        
        let width = frame.width
        let height = frame.height
        
        let maxY = frame.maxY * 0.1
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        projectLibraryCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        projectLibraryCollectionView.backgroundColor = .white
        
        addSubview(projectLibraryCollectionView)
    }
    
    private func prepareAddProjectButton() {
        
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: height, height: height)
        
        addProjectButton = UIButton(frame: buttonFrame)
        
        let addProjectImage = UIImage(named: "addProjectButtonImage")
        addProjectButton.setImage(addProjectImage, for: .normal)
        
        addSubview(addProjectButton)
    }
    
}


// MARK: - View Controller
final class ProjectLibraryViewController: UIViewController {
    
    private let mainView = ProjectLibraryMainView()
    fileprivate let viewModel = ProjectLibraryViewModel()
    
    private enum State {
        case `default`
        case loading
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
            self.view = mainView
        case .viewDidAppear:
            setAddProjectButtonTarget()
            registerCollectionViewCell()
            registerCollectionViewHeader()
        case .addProject:
            break
        default:
            break
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        state = .viewDidAppear
    }
    
    // MARK: - Methods
    private func setAddProjectButtonTarget() {
        mainView.addProjectButton.addTarget(self, action: #selector(didPressAddProjctButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressAddProjctButton() {
        state = .addProject
    }
    
    private func registerCollectionViewCell() {
        mainView.projectLibraryCollectionView.register(
            ProjectLibraryCollectionViewCell.self,
            forCellWithReuseIdentifier: "ProjectLibraryCell"
        )
    }
    
    private func registerCollectionViewHeader() {
        mainView.projectLibraryCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProjectLibraryCollectionViewHeader")
    }
}


extension ProjectLibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectLibraryCell", for: indexPath) as! ProjectLibraryCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProjectLibraryCollectionViewHeader", for: indexPath)
        
        return reusableView
    }
    
}


// MARK: - Cell
final class ProjectLibraryCollectionViewCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .black
    }
    
}

// Displaying the view controller
PlaygroundPage.current.liveView = ProjectLibraryViewController()
