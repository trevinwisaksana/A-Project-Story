//
//  StepCell.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

final class StepCell: UICollectionViewCell {
    
    var containerView = UIView()
    var stepCountLabel = UILabel()
    var lineSeparator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        prepareContainerView()
        prepareLineSeparator()
        prepareStepCount()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Other setup
    }
    
    func configure(with data: Step) {
        
    }
    
    private func prepareContainerView() {
        
        let width = frame.width
        let height = frame.height
        
        let containerViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        containerView.backgroundColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        addSubview(containerView)
    }
    
    private func prepareLineSeparator() {
        
        let width = frame.width
        let maxY = containerView.frame.maxY
        
        let lineSeparatorFrame = CGRect(x: 0, y: maxY, width: width, height: 1)
        lineSeparator.frame = lineSeparatorFrame
        lineSeparator.backgroundColor = UIColor(colorLiteralRed: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        
        addSubview(lineSeparator)
    }
    
    private func prepareStepCount() {
        
        let width = frame.width
        let height = frame.height
        
        let stepCountLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        stepCountLabel.frame = stepCountLabelFrame
        stepCountLabel.text = "1"
        stepCountLabel.font = UIFont(name: "Averta-Bold", size: width * 0.2)
        
        addSubview(stepCountLabel)
        
        stepCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineSeparator.snp.top).offset(2)
            make.left.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    
    
}
