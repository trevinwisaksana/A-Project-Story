//
//  CreateProjectMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

//////////////////////////////
// Create Project Main View //
//////////////////////////////

final class CreateProjectMainView: UIView {
    
    var cancelToCreateButton = UIButton()
    var createProjectButton = UIButton()
    var projectTitleTextField = UITextField()
    var projectDescriptionTextView = UITextView()
    var emailAddressTitleLabel = UILabel()
    var emailAddressTextField = UITextField()
    
    // Lines
    var projectTitleLineSeparator = UIView()
    var emailAddressTitleLineSeparator = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        
        prepareCancelButton()
        prepareCreateProjectButton()
        prepareProjectTitleTextField()
        prepareLineSeparator()
        prepareProjectDescriptionTextView()
        prepareEmailAddressTitleLabel()
        prepareEmailAddressTitleLineSeparator()
        prepareEmailAddressTextField()
    }
    
    private func setScreenSize() {
        let screenSize = UIScreen.main.bounds.size
        frame.size = screenSize
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
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
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        cancelToCreateButton.titleLabel?.font = buttonFont
        
        addSubview(cancelToCreateButton)
        
        cancelToCreateButton.snp.makeConstraints { (make) in
            make.leading.top.equalTo(22)
        }
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
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        createProjectButton.titleLabel?.font = buttonFont
        
        addSubview(createProjectButton)
        
        createProjectButton.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.right.equalTo(-22)
        }
    }
    
    private func prepareProjectTitleTextField() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.1
        
        let maxX = frame.maxX * 0.065
        let maxY = frame.maxY * 0.085
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        projectTitleTextField.frame = textFieldFrame
        
        projectTitleTextField.returnKeyType = .done
        
        projectTitleTextField.placeholder = "New Project Title"
        projectTitleTextField.textColor = .black
        
        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        let textFieldFont = UIFont(name: "Averta-Bold", size: frame.width * 0.08)
        projectTitleTextField.font = textFieldFont
        
        addSubview(projectTitleTextField)
        
        projectTitleTextField.snp.makeConstraints { (make) in
            make.top.equalTo(createProjectButton).offset(60)
            make.top.equalTo(cancelToCreateButton).offset(60)
            make.width.equalTo(width)
            make.leading.equalTo(21.5)
        }
    }
    
    private func prepareLineSeparator() {
        
        let width = frame.width * 0.88
        let height: CGFloat = 1.0
        
        let maxX = frame.maxX * 0.06
        let maxY = frame.maxY * 0.2
        
        let lineSeparatorFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        projectTitleLineSeparator.frame = lineSeparatorFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        projectTitleLineSeparator.backgroundColor = backgroundColor
        
        addSubview(projectTitleLineSeparator)
        
        projectTitleLineSeparator.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(frame.width * 0.88)
            make.top.equalTo(projectTitleTextField).offset(40)
            make.left.equalTo(23)
            make.right.equalTo(-23)
        }
    }
    
    private func prepareProjectDescriptionTextView() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.25
        
        let maxX = frame.maxX * 0.048
        let maxY = frame.maxY * 0.22
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        projectDescriptionTextView.frame = textFieldFrame
        
        projectDescriptionTextView.returnKeyType = .default
        
        projectDescriptionTextView.text = "Enter your project description..."
        projectDescriptionTextView.textColor = .lightGray
        
        let backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        projectDescriptionTextView.backgroundColor = backgroundColor
        
        let textFieldFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        projectDescriptionTextView.font = textFieldFont
        
        addSubview(projectDescriptionTextView)
        
        projectDescriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(projectTitleLineSeparator).offset(5)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.left.equalTo(17)
            make.right.equalTo(-17)
        }
    }
    
    private func prepareEmailAddressTitleLabel() {
        
        let width = frame.width * 0.4
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.51
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        emailAddressTitleLabel.frame = buttonFrame
        
        emailAddressTitleLabel.text = "Email address"
        
        let textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        emailAddressTitleLabel.textColor = textColor
        
        let buttonFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        emailAddressTitleLabel.font = buttonFont
        
        addSubview(emailAddressTitleLabel)
        
        emailAddressTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(projectDescriptionTextView.snp.bottom).offset(0)
            make.width.equalTo(width)
            make.left.equalTo(22)
        }
    }
    
    private func prepareEmailAddressTitleLineSeparator() {
        
        let width = frame.width * 0.88
        let height: CGFloat = 1.0
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.55
        
        let lineSeparatorFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        emailAddressTitleLineSeparator.frame = lineSeparatorFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        emailAddressTitleLineSeparator.backgroundColor = backgroundColor
        
        addSubview(emailAddressTitleLineSeparator)
        
        emailAddressTitleLineSeparator.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(width)
            make.top.equalTo(emailAddressTitleLabel.snp.bottom).offset(4)
            make.left.equalTo(23)
            make.right.equalTo(-23)
        }
    }
    
    private func prepareEmailAddressTextField() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.555
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        emailAddressTextField.frame = textFieldFrame
        
        emailAddressTextField.returnKeyType = .done
        emailAddressTextField.keyboardType = .emailAddress
        emailAddressTextField.autocorrectionType = .no
        emailAddressTextField.autocapitalizationType = .none
        
        emailAddressTextField.placeholder = "Enter your email address..."
        emailAddressTextField.textColor = .black
        
        let textFieldFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        emailAddressTextField.font = textFieldFont
        
        addSubview(emailAddressTextField)
        
        emailAddressTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailAddressTitleLineSeparator.snp.bottom).offset(8)
            make.width.equalTo(width)
            make.leading.equalTo(22)
        }
    }
    
    // MARK: - Error Handling
    func displayProjectTitleAlert() {
        
        let placeholderColor = UIColor(colorLiteralRed: 225/255, green: 0/255, blue: 2/255, alpha: 0.6)
        projectTitleTextField.attributedPlaceholder = NSAttributedString(string: "New Project Title", attributes: [NSForegroundColorAttributeName: placeholderColor])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(2)
            self.projectTitleTextField.alpha = 0
            self.projectTitleTextField.alpha = 0.6
        }, completion: { (_) in
            self.projectTitleTextField.alpha = 0.6
        })
    }
    
    func displayEmailAddressAlert() {
        let placeholderColor = UIColor(colorLiteralRed: 225/255, green: 0/255, blue: 2/255, alpha: 0.6)
        emailAddressTextField.attributedPlaceholder = NSAttributedString(string: "Enter your email address...", attributes: [NSForegroundColorAttributeName: placeholderColor])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(2)
            self.emailAddressTextField.alpha = 0
            self.emailAddressTextField.alpha = 0.6
        }, completion: { (_) in
            self.emailAddressTextField.alpha = 0.6
        })
    }
    
}
