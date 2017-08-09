//
//  StepMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/10/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class StepMainView: UIView {
    
    // Buttons
    var backButton = UIButton()
    var editStepButton = UIButton()
    
    // Text Fields
    var stepTitleTextField = UITextField()
    
    // Text View
    var stepDescriptionTextView = UITextView()
    
    // Line Separator
    var stepTitleLineSeparator = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        
        prepareBackButton()
        prepareEditStepButton()
        prepareStepTitleTextField()
        prepareLineSeparator()
        prepareStepDescriptionTextView()
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
    
    private func prepareEditStepButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        editStepButton.frame = buttonFrame
        
        editStepButton.setTitle("Edit", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        editStepButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        editStepButton.titleLabel?.font = buttonFont
        
        addSubview(editStepButton)
        
        editStepButton.snp.makeConstraints { (make) in
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
        
        stepTitleTextField.text = "Step 1: Buy New Tools"
        stepTitleTextField.textColor = .black
        
        let fontURL = Bundle.main.url(forResource: "Averta-Bold", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        let textFieldFont = UIFont(name: "Averta-Bold", size: frame.width * 0.08)
        stepTitleTextField.font = textFieldFont
        
        addSubview(stepTitleTextField)
        
        stepTitleTextField.snp.makeConstraints { (make) in
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
        stepDescriptionTextView.textColor = .black
        
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
    
    // MARK: - Error Handling
    func displayStepTitleAlert() {
        
        let placeholderColor = UIColor(colorLiteralRed: 225/255, green: 0/255, blue: 2/255, alpha: 0.6)
        stepTitleTextField.attributedPlaceholder = NSAttributedString(string: "Step 1: New Title", attributes: [NSForegroundColorAttributeName: placeholderColor])
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(2)
            self.stepTitleTextField.alpha = 0
            self.stepTitleTextField.alpha = 0.6
        }, completion: nil)
    }
    
}
