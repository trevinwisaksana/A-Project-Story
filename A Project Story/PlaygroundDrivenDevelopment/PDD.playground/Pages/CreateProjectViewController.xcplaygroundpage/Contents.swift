//
//
//
//
//import UIKit
//import PlaygroundSupport
//import SnapKit
//
//
//////////////////////////////////////
//// Create Project View Controller //
//////////////////////////////////////
//
//final class CreateProjectViewController: UIViewController {
//    
//    private let mainView = CreateProjectMainView()
//    
//    private enum State {
//        case `default`
//        case loading
//        case viewDidAppear
//        case cancelToAdd
//    }
//    
//    private var state: State = .default {
//        didSet {
//            didChange(state)
//        }
//    }
//    
//    private func didChange(_ state: State) {
//        switch state {
//        case .loading:
//            self.view = mainView
//        case .viewDidAppear:
//            setcancelToCreateButtonTarget()
//        case .cancelToAdd:
//            dismiss(animated: true, completion: nil)
//        default:
//            break
//        }
//    }
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        state = .loading
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        state = .viewDidAppear
//    }
//    
//    // MARK: - Methods
//    private func setcancelToCreateButtonTarget() {
//        mainView.cancelToCreateButton.addTarget(self, action: #selector(didPressCancelToCreateButton), for: .touchUpInside)
//    }
//    
//    @objc
//    private func didPressCancelToCreateButton() {
//        state = .cancelToAdd
//    }
//    
//}
//
//
////////////////////////////////
//// Create Project Main View //
////////////////////////////////
//
//final class CreateProjectMainView: UIView {
//    
//    var cancelToCreateButton = UIButton()
//    var createProjectButton = UIButton()
//    var projectNameTextField = UITextField()
//    var projectDescriptionTextView = UITextView()
//    var emailAddressTitleLabel = UILabel()
//    var emailAddressTextField = UITextField()
//    
//    // Lines
//    var projectNameLineSeparator = UIView()
//    var emailAddressTitleLineSeparator = UIView()
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setScreenSize()
//        
//        prepareCancelButton()
//        prepareCreateProjectButton()
//        prepareProjectNameTextField()
//        prepareLineSeparator()
//        prepareProjectDescriptionTextView()
//        prepareEmailAddressTitleLabel()
//        prepareEmailAddressTitleLineSeparator()
//        prepareEmailAddressTextField()
//    }
//    
//    // Only for PDD
//    private func setScreenSize() {
//        // iPhones
//        let iPhone5s = CGSize(width: 320, height: 568)
//        let iPhone7 = CGSize(width: 375, height: 667)
//        let iPhone7Plus = CGSize(width: 414, height: 736)
//        
//        let screenSize = iPhone5s
//        frame.size = screenSize
//        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
//    }
//    
//    private func prepareCancelButton() {
//        
//        let width = frame.width * 0.2
//        let height = frame.height * 0.04
//        
//        let maxX = frame.maxX * 0.05
//        let maxY = frame.maxY * 0.03
//        
//        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        cancelToCreateButton.frame = buttonFrame
//        
//        cancelToCreateButton.setTitle("Cancel", for: .normal)
//        cancelToCreateButton.setTitleColor(.red, for: .normal)
//        
//        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
//        cancelToCreateButton.titleLabel?.font = buttonFont
//        
//        addSubview(cancelToCreateButton)
//        
//        cancelToCreateButton.snp.makeConstraints { (make) in
//            make.leading.top.equalTo(22)
//        }
//    }
//    
//    private func prepareCreateProjectButton() {
//        
//        let width = frame.width * 0.2
//        let height = frame.height * 0.04
//        
//        let maxX = frame.maxX * 0.75
//        let maxY = frame.maxY * 0.03
//        
//        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        createProjectButton.frame = buttonFrame
//        
//        createProjectButton.setTitle("Create", for: .normal)
//        
//        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
//        createProjectButton.setTitleColor(fontColor, for: .normal)
//        
//        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
//        createProjectButton.titleLabel?.font = buttonFont
//        
//        addSubview(createProjectButton)
//        
//        createProjectButton.snp.makeConstraints { (make) in
//            make.top.equalTo(22)
//            make.right.equalTo(-22)
//        }
//    }
//    
//    private func prepareProjectNameTextField() {
//        
//        let width = frame.width * 0.8
//        let height = frame.height * 0.1
//        
//        let maxX = frame.maxX * 0.065
//        let maxY = frame.maxY * 0.085
//        
//        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        projectNameTextField.frame = textFieldFrame
//        
//        projectNameTextField.placeholder = "Project Name"
//        projectNameTextField.textColor = .black
//        
//        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
//        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
//        let textFieldFont = UIFont(name: "Averta-Bold", size: frame.width * 0.08)
//        projectNameTextField.font = textFieldFont
//        
//        addSubview(projectNameTextField)
//        
//        projectNameTextField.snp.makeConstraints { (make) in
//            make.top.equalTo(createProjectButton).offset(60)
//            make.top.equalTo(cancelToCreateButton).offset(60)
//            make.leading.equalTo(22)
//        }
//    }
//    
//    private func prepareLineSeparator() {
//        
//        let width = frame.width * 0.88
//        let height: CGFloat = 1.0
//        
//        let maxX = frame.maxX * 0.06
//        let maxY = frame.maxY * 0.2
//        
//        let lineSeparatorFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        projectNameLineSeparator.frame = lineSeparatorFrame
//        
//        let backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
//        projectNameLineSeparator.backgroundColor = backgroundColor
//        
//        addSubview(projectNameLineSeparator)
//        
//        projectNameLineSeparator.snp.makeConstraints { (make) in
//            make.height.equalTo(1)
//            make.width.equalTo(frame.width * 0.9)
//            make.top.equalTo(projectNameTextField).offset(40)
//            make.left.equalTo(-22)
//        }
//    }
//    
//    private func prepareProjectDescriptionTextView() {
//        
//        let width = frame.width * 0.9
//        let height = frame.height * 0.3
//        
//        let maxX = frame.maxX * 0.048
//        let maxY = frame.maxY * 0.21
//        
//        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        projectDescriptionTextView.frame = textFieldFrame
//        
//        projectDescriptionTextView.text = "Enter your project description..."
//        projectDescriptionTextView.textColor = .lightGray
//        
//        let backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
//        projectDescriptionTextView.backgroundColor = backgroundColor
//        
//        let textFieldFont = UIFont(name: "Avenir", size: frame.width * 0.04)
//        projectDescriptionTextView.font = textFieldFont
//        
//        addSubview(projectDescriptionTextView)
//        
//        /*
//         projectDescriptionTextView.snp.makeConstraints { (make) in
//         make.top.equalTo(projectNameTextField).offset(60)
//         make.leading.equalTo(22)
//         }
//         */
//    }
//    
//    private func prepareEmailAddressTitleLabel() {
//        
//        let width = frame.width * 0.4
//        let height = frame.height * 0.04
//        
//        let maxX = frame.maxX * 0.05
//        let maxY = frame.maxY * 0.51
//        
//        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        emailAddressTitleLabel.frame = buttonFrame
//        
//        emailAddressTitleLabel.text = "Email address"
//        
//        let textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
//        emailAddressTitleLabel.textColor = textColor
//        
//        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.04)
//        emailAddressTitleLabel.font = buttonFont
//        
//        addSubview(emailAddressTitleLabel)
//        
//        /*
//         emailAddressTitleLabel.snp.makeConstraints { (make) in
//         make.leading.top.equalTo(22)
//         }
//         */
//    }
//    
//    private func prepareEmailAddressTitleLineSeparator() {
//        
//        let width = frame.width * 0.88
//        let height: CGFloat = 1.0
//        
//        let maxX = frame.maxX * 0.05
//        let maxY = frame.maxY * 0.55
//        
//        let lineSeparatorFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        emailAddressTitleLineSeparator.frame = lineSeparatorFrame
//        
//        let backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
//        emailAddressTitleLineSeparator.backgroundColor = backgroundColor
//        
//        addSubview(emailAddressTitleLineSeparator)
//    }
//    
//    private func prepareEmailAddressTextField() {
//        
//        let width = frame.width * 0.9
//        let height = frame.height * 0.04
//        
//        let maxX = frame.maxX * 0.05
//        let maxY = frame.maxY * 0.555
//        
//        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
//        emailAddressTextField.frame = textFieldFrame
//        
//        emailAddressTextField.placeholder = "Enter your email address..."
//        emailAddressTextField.textColor = .black
//        
//        let textFieldFont = UIFont(name: "Avenir", size: frame.width * 0.04)
//        emailAddressTextField.font = textFieldFont
//        
//        addSubview(emailAddressTextField)
//    }
//    
//}
//
//
//
//
//// Displaying the view controller
//PlaygroundPage.current.liveView = CreateProjectViewController()
//PlaygroundPage.current.needsIndefiniteExecution = true
