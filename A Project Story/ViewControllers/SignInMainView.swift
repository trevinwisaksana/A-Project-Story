//
//  SignInMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/22/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class SignInMainView: UIView {
    
    let signUpCalloutLabel = UILabel()
    let signUpButton = UIButton()
    let logInButton = UIButton()
    let signInTitleLabel = UILabel()
    let passwordTitleLabel = UILabel()
    let passwordTitleLineSeparator = UIView()
    let passwordTextField = UITextField()
    let emailAddressTitleLabel = UILabel()
    let emailAddressTitleLineSeparator = UIView()
    let emailAddressTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        
        prepareSignUpCalloutLabel()
        prepareSignUpButton()
        prepareLogInButton()
        prepareSignInTitleLabel()
        prepareEmailAddressTitleLabel()
        prepareEmailAddressTitleLineSeparator()
        prepareEmailAddressTextField()
        preparePasswordTitleLabel()
        preparePasswordLineSeparator()
        preparePasswordTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScreenSize() {
        let screenSize = UIScreen.main.bounds.size
        frame.size = screenSize
        roundCorners([.topLeft, .topRight], radius: 10)
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    private func prepareSignUpCalloutLabel() {
        let width = frame.width * 0.88
        let height = frame.height * 0.03
        
        let maxX = frame.maxX * 0.065
        let maxY = frame.maxY * 0.085
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        signUpCalloutLabel.frame = textFieldFrame
        
        signUpCalloutLabel.text = "Don't have an account?"
        signUpCalloutLabel.textColor = .black
        
        let textFieldFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        signUpCalloutLabel.font = textFieldFont
        
        addSubview(signUpCalloutLabel)
        
        signUpCalloutLabel.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.top.equalTo(22)
            make.width.equalTo(width)
        }
    }
    
    private func prepareSignUpButton() {
        let width = frame.width * 0.15
        let height = frame.height * 0.03
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        signUpButton.frame = buttonFrame
        
        signUpButton.setTitle("Sign Up", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        signUpButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        signUpButton.titleLabel?.font = buttonFont
        
        addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.left.equalTo(signUpCalloutLabel.snp.right).offset(0)
            make.right.equalTo(-frame.width * 0.35)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareLogInButton() {
        let width = frame.width * 0.12
        let height = frame.height * 0.03
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        logInButton.frame = buttonFrame
        
        logInButton.setTitle("Log In", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        logInButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        logInButton.titleLabel?.font = buttonFont
        
        addSubview(logInButton)
        
        logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.left.equalTo(signUpButton.snp.right).offset(frame.width * 0.12)
            make.right.equalTo(0)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareSignInTitleLabel() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.1
        
        let maxX = frame.maxX * 0.065
        let maxY = frame.maxY * 0.085
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        signInTitleLabel.frame = textFieldFrame
        
        signInTitleLabel.text = "Sign In"
        signInTitleLabel.textColor = .black
        
        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        let textFieldFont = UIFont(name: "Averta-Bold", size: frame.width * 0.08)
        signInTitleLabel.font = textFieldFont
        
        addSubview(signInTitleLabel)
        
        signInTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.width.equalTo(width)
            make.leading.equalTo(21.5)
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
            make.top.equalTo(signInTitleLabel.snp.bottom).offset(30)
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
    
    private func preparePasswordTitleLabel() {
        
        let width = frame.width * 0.4
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.51
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        passwordTitleLabel.frame = buttonFrame
        
        passwordTitleLabel.text = "Password"
        
        let textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        passwordTitleLabel.textColor = textColor
        
        let buttonFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        passwordTitleLabel.font = buttonFont
        
        addSubview(passwordTitleLabel)
        
        passwordTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailAddressTextField.snp.bottom).offset(frame.height * 0.16)
            make.width.equalTo(width)
            make.left.equalTo(22)
        }
    }
    
    private func preparePasswordLineSeparator() {
        
        let width = frame.width * 0.88
        let height: CGFloat = 1.0
        
        let maxX = frame.maxX * 0.06
        let maxY = frame.maxY * 0.2
        
        let lineSeparatorFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        passwordTitleLineSeparator.frame = lineSeparatorFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        passwordTitleLineSeparator.backgroundColor = backgroundColor
        
        addSubview(passwordTitleLineSeparator)
        
        passwordTitleLineSeparator.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(frame.width * 0.88)
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(4)
            make.left.equalTo(23)
            make.right.equalTo(-23)
        }
    }
    
    private func preparePasswordTextField() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.555
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        passwordTextField.frame = textFieldFrame
        
        passwordTextField.returnKeyType = .done
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "Enter your password..."
        passwordTextField.textColor = .black
        
        let textFieldFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        passwordTextField.font = textFieldFont
        
        addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTitleLineSeparator.snp.bottom).offset(8)
            make.width.equalTo(width)
            make.leading.equalTo(22)
        }
    }

}
