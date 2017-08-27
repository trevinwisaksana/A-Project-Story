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
    var nextButton = UIButton()
    // Text Field
    var projectTitleTextField = UITextField()
    // Text View
    var stepDescriptionTextView = UITextView()
    // Line Separator
    var projectTitleLineSeparator = UIView()
    // Collection View
    var stepCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        
        prepareBackButton()
        prepareNextButton()
        prepareProjectTitleTextField()
        prepareLineSeparator()
        prepareStepCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Other setup
        roundCorners([.topLeft, .topRight], radius: 10)
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
    
    private func prepareNextButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        nextButton.frame = buttonFrame
        
        nextButton.setTitle("Next", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        nextButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        nextButton.titleLabel?.font = buttonFont
        
        addSubview(nextButton)
        
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(17)
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
        
        projectTitleTextField.text = "3D Printed Gearbox"
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
    
    func registerCollectionViewCell() {
        stepCollectionView.register(StepCell.self, forCellWithReuseIdentifier: "StepCell")
    }
    
    func registerCollectionViewHeader() {
        stepCollectionView.register(StepCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "StepCollectionViewHeader")
    }
    
    private func prepareStepCollectionView() {
        
        let width = frame.width
        let height = frame.height * 0.7
        
        let maxY = frame.maxY * 0.15
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        stepCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        stepCollectionView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)

        
        stepCollectionView.showsVerticalScrollIndicator = false
        stepCollectionView.alwaysBounceVertical = true
        
        addSubview(stepCollectionView)
        
        stepCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(projectTitleLineSeparator.snp.bottom).offset(5)
        }
    }
    
    func assignProjectTitle(with title: String) {
        projectTitleTextField.text = title
    }
}
