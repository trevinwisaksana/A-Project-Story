//
//  NewStepMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class AddStepMainView: UIView {
    
    // Buttons
    var cancelButton = UIButton()
    var addStepButton = UIButton()
    
    // Text Fields
    var stepTitleTextField = UITextField()
    
    // Text View
    var stepDescriptionTextView = UITextView()
    
    // Line Separator
    var stepTitleLineSeparator = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        
        prepareCancelButton()
        prepareAddStepButton()
        prepareStepTitleTextField()
        prepareLineSeparator()
        prepareStepDescriptionTextView()
    }
    
    private func setScreenSize() {
        frame.size = UIScreen.main.bounds.size
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    private func prepareCancelButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        cancelButton.frame = buttonFrame
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        cancelButton.titleLabel?.font = buttonFont
        
        addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) in
            make.leading.top.equalTo(22)
        }
    }
    
    private func prepareAddStepButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        addStepButton.frame = buttonFrame
        
        addStepButton.setTitle("Add", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        addStepButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        addStepButton.titleLabel?.font = buttonFont
        
        addSubview(addStepButton)
        
        addStepButton.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.right.equalTo(-22)
        }
    }
    
    private func prepareStepTitleTextField() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.1
        
        let maxX = frame.maxX * 0.065
        let maxY = frame.maxY * 0.085
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        stepTitleTextField.frame = textFieldFrame
        
        stepTitleTextField.returnKeyType = .done
        
        stepTitleTextField.placeholder = "Step 1: New Title"
        stepTitleTextField.textColor = .black
        
        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        let textFieldFont = UIFont(name: "Averta-Bold", size: frame.width * 0.08)
        stepTitleTextField.font = textFieldFont
        
        addSubview(stepTitleTextField)
        
        stepTitleTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cancelButton).offset(60)
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
        stepTitleLineSeparator.frame = lineSeparatorFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 213/255, green: 213/255, blue: 213/255, alpha: 1)
        stepTitleLineSeparator.backgroundColor = backgroundColor
        
        addSubview(stepTitleLineSeparator)
        
        stepTitleLineSeparator.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(frame.width * 0.88)
            make.top.equalTo(stepTitleTextField).offset(40)
            make.left.equalTo(23)
            make.right.equalTo(-23)
        }
    }
    
    private func prepareStepDescriptionTextView() {
        
        let width = frame.width * 0.88
        let height = frame.height * 0.8
        
        let maxX = frame.maxX * 0.048
        let maxY = frame.maxY * 0.22
        
        let textFieldFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        stepDescriptionTextView.frame = textFieldFrame
        
        stepDescriptionTextView.returnKeyType = .default
        
        stepDescriptionTextView.text = "Describe this step of your project..."
        stepDescriptionTextView.textColor = .lightGray
        
        let backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        stepDescriptionTextView.backgroundColor = backgroundColor
        
        let textFieldFont = UIFont(name: "Avenir-Medium", size: frame.width * 0.04)
        stepDescriptionTextView.font = textFieldFont
        
        addSubview(stepDescriptionTextView)
        
        stepDescriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(stepTitleLineSeparator).offset(10)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.left.equalTo(17)
            make.right.equalTo(-17)
        }
    }

    
}
