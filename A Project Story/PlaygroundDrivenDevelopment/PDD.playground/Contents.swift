//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
@testable import SnapKit


////////////////
// Data Model //
////////////////

// MARK: - Data Model
final class ProjectDataModel {
    var projectName: String
    let projectOwner: String
    
    init(projectName: String, projectOwner: String) {
        self.projectName = projectName
        self.projectOwner = projectOwner
    }
}

////////////////
// View Model //
////////////////

// MARK: - View Model
final class ProjectLibraryViewModel {

    private var listOfProjects = [ProjectDataModel]()
    
    func numberOfItemsIn(section: Int) -> Int {
        return listOfProjects.count
    }
    
    func projectTitleAt(indexPath: IndexPath) -> String {
        return listOfProjects[indexPath.row].projectName
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
    }
}


///////////////////////////////
// Project Library Main View //
///////////////////////////////

final class ProjectLibraryMainView: UIView {
    
    var addProjectButton: UIButton!
    var projectLibraryCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        prepareCollectionView()
        prepareAddProjectButton()
    }
    
    // Only for PDD
    private func setScreenSize() {
        // iPhone 7 Plus
        let screenSize = CGSize(width: 414, height: 736)
        frame.size = screenSize
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    private func prepareCollectionView() {
        
        let width = frame.width
        let height = frame.height
        
        let maxY = frame.maxY * 0.07
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        projectLibraryCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        projectLibraryCollectionView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        addSubview(projectLibraryCollectionView)
        
        projectLibraryCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.leading.trailing.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(50)
        }
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
        
        addProjectButton.snp.makeConstraints { (make) in
            make.leading.top.equalTo(22)
        }
    }
    
}


/////////////////////////////////////
// Project Library View Controller //
/////////////////////////////////////

final class ProjectLibraryViewController: UIViewController {
    
    private let mainView = ProjectLibraryMainView()
    fileprivate let viewModel = ProjectLibraryViewModel()
    
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
            self.view = mainView
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
        present(AddProjectViewController(), animated: true, completion: nil)
    }
}



///////////////////////////////
// Collection View Extension //
///////////////////////////////

extension ProjectLibraryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return viewModel.numberOfItemsIn(section: section)
        return 1
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


//////////////////////////
// Collection View Cell //
//////////////////////////

final class ProjectLibraryCollectionViewCell: UICollectionViewCell {
    
    var containerView = UIView()
    var projectTitleLabel = UILabel()
    var projectArtwork = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        prepareContainerView()
    }
    
    func configure(with viewModel: ProjectLibraryViewModel, forRowAtIndexPath indexPath: IndexPath) {
        projectTitleLabel.text = viewModel.projectTitleAt(indexPath: indexPath)
    }
    
    private func prepareContainerView() {
        
        let width = frame.width * 0.8
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let containerViewFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .green
        
        addSubview(containerView)
    }
}


///////////////////
// Reusable View //
///////////////////

final class ProjectLibraryReusableView: UICollectionReusableView {
    
    private var sectionTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSectionTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSectionTitle() {
        let width = frame.width
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let sectionTitleFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        sectionTitle.frame = sectionTitleFrame
        
        sectionTitle.text = "Projects"
        
        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        let titleFont = UIFont(name: "Averta-Bold", size: 35)
        sectionTitle.font = titleFont
        
        addSubview(sectionTitle)
    }
}


/////////////////////////////////
// Add Project View Controller //
/////////////////////////////////

final class AddProjectViewController: UIViewController {
    
    private let mainView = AddProjectMainView()
    
    private enum State {
        case `default`
        case loading
        case viewDidAppear
        case cancelToAdd
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
            setcancelToCreateButtonTarget()
        case .cancelToAdd:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        state = .viewDidAppear
    }
    
    // MARK: - Methods
    private func setcancelToCreateButtonTarget() {
        mainView.cancelToCreateButton.addTarget(self, action: #selector(didPressCancelToCreateButton), for: .touchUpInside)
    }
    
    @objc
    private func didPressCancelToCreateButton() {
        state = .cancelToAdd
    }
    
}


///////////////////////////
// Add Project Main View //
///////////////////////////

final class AddProjectMainView: UIView {
    
    var cancelToCreateButton = UIButton()
    var createProjectButton = UIButton()
    var projectNameTextField = UITextField()

    // Lines
    var projectNameLineSeparator = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        prepareCancelButton()
        prepareCreateProjectButton()
        prepareProjectNameTextField()
        prepareLineSeparator()
    }
    
    private func prepareCancelButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        cancelToCreateButton.frame = buttonFrame
        
        cancelToCreateButton.setTitle("Cancel", for: .normal)
        cancelToCreateButton.setTitleColor(.red, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: 20)
        cancelToCreateButton.titleLabel?.font = buttonFont
        
        addSubview(cancelToCreateButton)
    }
    
    private func prepareCreateProjectButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        createProjectButton.frame = buttonFrame
        
        createProjectButton.setTitle("Create", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        createProjectButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: 20)
        createProjectButton.titleLabel?.font = buttonFont
        
        addSubview(createProjectButton)
    }
    
    private func prepareProjectNameTextField() {
        
        let width = frame.width * 0.8
        let height = frame.height * 0.1
        
        let maxX = frame.maxX * 0.065
        let maxY = frame.maxY * 0.085
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        projectNameTextField.frame = textFieldFrame
        
        projectNameTextField.placeholder = "Project Name"
        projectNameTextField.textColor = .black
      
        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        let textFieldFont = UIFont(name: "Averta-Bold", size: 35)
        projectNameTextField.font = textFieldFont
        
        addSubview(projectNameTextField)
    }
    
    private func prepareLineSeparator() {
        
        let width = frame.width * 0.85
        let height: CGFloat = 1.0
        
        let maxX = frame.maxX * 0.065
        let maxY = frame.maxY * 0.2
        
        let lineSeparatorFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        projectNameLineSeparator.frame = lineSeparatorFrame
        
        projectNameLineSeparator.backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        
        addSubview(projectNameLineSeparator)
    }
    
}


// Displaying the view controller
PlaygroundPage.current.liveView = ProjectLibraryViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
