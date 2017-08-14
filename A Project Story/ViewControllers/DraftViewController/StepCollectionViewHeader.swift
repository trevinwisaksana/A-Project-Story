//
//  StepCollectionViewHeader.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class StepCollectionViewHeader: UICollectionReusableView {
    
    // UIElements
    var sectionTitleLabel = UILabel()
    var addStepButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSectionTitleLabel()
        prepareAddStepButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSectionTitleLabel() {
        
        let width = frame.width
        let height = frame.height
        
        let maxX = frame.maxX * 0.055
        
        let sectionTitleFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        sectionTitleLabel.frame = sectionTitleFrame
        
        let titleFont = UIFont(name: "Averta-Bold", size: frame.width * 0.07)
        sectionTitleLabel.font = titleFont
        sectionTitleLabel.text = "Step"
        
        addSubview(sectionTitleLabel)
    }

    private func prepareAddStepButton() {
        
        let height = frame.height * 0.8
        
        let maxX = frame.maxX * 0.85
        
        let buttonFrame = CGRect(x: maxX, y: 2, width: height, height: height)
        addStepButton = UIButton(frame: buttonFrame)
        
        let addProjectImage = UIImage(named: "addProjectButtonImage")
        addStepButton.setImage(addProjectImage, for: .normal)
        addStepButton.imageView?.contentMode = .scaleAspectFit
        
        addSubview(addStepButton)
        
        /*
        addStepButton.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.right.equalTo(-22)
        }
        */
    }
}
