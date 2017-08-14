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
    var stepTitleLabel = UILabel()
    var lastEditedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        prepareContainerView()
        prepareLineSeparator()
        prepareStepCountLabel()
        prepareStepTitleLabel()
        prepareLastEditedLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Other setup
    }
    
    func configure(with data: Step) {
        stepCountLabel.text = "\(data.index)"
        stepTitleLabel.text = data.title
    }
    
    private func prepareContainerView() {
        
        let width = frame.width
        let height = frame.height
        
        let containerViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        containerView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        addSubview(containerView)
    }
    
    private func prepareLineSeparator() {
        
        let width = frame.width
        let maxY = containerView.frame.maxY
        
        let lineSeparatorFrame = CGRect(x: 0, y: maxY, width: width, height: 1)
        lineSeparator.frame = lineSeparatorFrame
        lineSeparator.backgroundColor = UIColor(colorLiteralRed: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        
        addSubview(lineSeparator)
        
        lineSeparator.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(1)
            make.bottom.left.right.equalTo(0)
        }
    }
    
    private func prepareStepCountLabel() {
        
        let width = frame.width * 0.1
        let height = frame.height
        
        let stepCountLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        stepCountLabel.frame = stepCountLabelFrame
        stepCountLabel.text = "1"
        stepCountLabel.font = UIFont(name: "Averta-Semibold", size: frame.width * 0.2)
        stepCountLabel.textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        addSubview(stepCountLabel)
        
        stepCountLabel.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.bottom.equalTo(lineSeparator.snp.top).offset(5)
            make.left.equalTo(0)
        }
    }
    
    private func prepareStepTitleLabel() {
        
        let width = frame.width * 0.8
        let height = frame.height * 0.5
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.2
        
        let stepTitleLabelFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        stepTitleLabel.frame = stepTitleLabelFrame
        stepTitleLabel.text = "Buy new tools"
        stepTitleLabel.textAlignment = .left
        stepTitleLabel.font = UIFont(name: "Averta-Semibold", size: width * 0.09)
        stepTitleLabel.textColor = .black
        
        addSubview(stepTitleLabel)
        
        stepTitleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.left.equalTo(stepCountLabel.snp.right).offset(12)
            make.top.equalTo(stepCountLabel.snp.top).offset(4)
        }
    }
    
    private func prepareLastEditedLabel() {
        
        let width = frame.width * 0.8
        let height = frame.height * 0.5
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.2
        
        let lastEditedLabelFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        lastEditedLabel.frame = lastEditedLabelFrame
        lastEditedLabel.text = "Last edited: August 14, 2017"
        lastEditedLabel.textAlignment = .left
        lastEditedLabel.font = UIFont(name: "Avenir-Medium", size: width * 0.05)
        lastEditedLabel.textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        addSubview(lastEditedLabel)
        
        lastEditedLabel.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.left.equalTo(stepCountLabel.snp.right).offset(12)
            make.top.equalTo(stepTitleLabel.snp.bottom).offset(-10)
        }
    }
}
