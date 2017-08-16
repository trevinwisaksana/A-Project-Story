//
//  Keyboard+Toolbar.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/15/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    func addKeyboardFontToolbar(textView: UITextView) {
        
        let toolbarContainer = prepareToolbarContainer()
        let topLineBorder = prepareTopLineBorder()
        
        let midYPosition = toolbarContainer.frame.midY * 0.5
        let buttonWidth = view.frame.width * 0.05
        let buttonHeight = view.frame.height * 0.06
        
        let boldFontButton = prepareBoldFontButton()
        let boldFontButtonXPos = toolbarContainer.frame.width * 0.05
        let boldFontButtonFrame = CGRect(x: boldFontButtonXPos, y: midYPosition, width: buttonWidth, height: buttonHeight)
        boldFontButton.frame = boldFontButtonFrame
        
        let italicizeFontButton = prepareItalicizeFontButton()
        let italicizeFontButtonXPos = toolbarContainer.frame.width * 0.2
        let italicizeFontButtonFrame = CGRect(x: italicizeFontButtonXPos, y: midYPosition, width: buttonWidth, height: buttonHeight)
        italicizeFontButton.frame = italicizeFontButtonFrame
        
        toolbarContainer.addSubview(topLineBorder)
        toolbarContainer.addSubview(boldFontButton)
        toolbarContainer.addSubview(italicizeFontButton)
        
        boldFontButton.snp.makeConstraints { (make) in
            make.center.centerY.equalTo(toolbarContainer.frame.midY)
            make.left.equalTo(view.frame.width * 0.07)
            make.top.bottom.equalTo(0)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        italicizeFontButton.snp.makeConstraints { (make) in
            make.center.centerY.equalTo(toolbarContainer.frame.midY)
            make.left.equalTo(view.frame.width * 0.19)
            make.top.bottom.equalTo(0)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
        
        textView.inputAccessoryView = toolbarContainer
    }
    
    private func prepareToolbarContainer() -> UIView {
        let toolbarContainer = UIView()
        
        let toolbarWidth = view.frame.width
        let toolbarHeight = view.frame.height * 0.07
        let toolbarContainerFrame = CGRect(x: 0, y: 0, width: toolbarWidth, height: toolbarHeight)
        toolbarContainer.frame = toolbarContainerFrame
        
        toolbarContainer.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        return toolbarContainer
    }
    
    private func prepareTopLineBorder() -> UIView {
        let lineSeparator = UIView()
        
        let width = view.frame.width
        let lineSeparatorFrame = CGRect(x: 0, y: 0, width: width, height: 1)
        lineSeparator.frame = lineSeparatorFrame
        
        lineSeparator.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        return lineSeparator
    }
    
    private func prepareBoldFontButton() -> UIButton {
        let boldFontButton = UIButton()
        
        let boldFontButtonImage = UIImage(named: "BoldButtonIcon")
        boldFontButton.setImage(boldFontButtonImage, for: .normal)
        boldFontButton.imageView?.contentMode = .scaleAspectFit
        
        boldFontButton.addTarget(self, action: #selector(didPressBoldenFontButton), for: .touchUpInside)
        
        return boldFontButton
    }
    
    private func prepareItalicizeFontButton() -> UIButton {
        let italicizeFontButton = UIButton()
        
        let italicizeButtonImage = UIImage(named: "ItalicizeButtonIcon")
        italicizeFontButton.setImage(italicizeButtonImage, for: .normal)
        italicizeFontButton.imageView?.contentMode = .scaleAspectFit
        
        italicizeFontButton.addTarget(self, action: #selector(didPressItalicizeButton), for: .touchUpInside)
        
        return italicizeFontButton
    }
    
    func didPressItalicizeButton() {
        
    }
    
    func didPressBoldenFontButton() {
        view.endEditing(true)
    }
    
    func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
}
