//
//  DraftMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class DraftMainView: UIView {
    
    // Buttons
    var backButton = UIButton()
    var saveButton = UIButton()
    
    // Text Fields
    var stepTitleTextField = UITextField()
    var projectTitleTextField = UITextField()
    
    // Text Views
    
    // Line Separator
    var projectTitleLineSeparator = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        
        prepareBackButton()
        prepareProjectTitleTextField()
        prepareLineSeparator()
    }
    
    private func setScreenSize() {
        frame.size = UIScreen.main.bounds.size
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    private func prepareBackButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        backButton.frame = buttonFrame
        
        let backButtonImage = UIImage(named: "backButtonIcon")
        backButton.setImage(backButtonImage, for: .normal)
        
        addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.leading.equalTo(22)
            make.top.equalTo(25)
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
            make.top.equalTo(backButton).offset(60)
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
    
}
