//
//  DraftCollectionViewCell.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/7/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class DraftCollectionViewCell: UICollectionViewCell {
    
    var containerView = UIView()
    var projectTitleLabel = UILabel()
    var unpublishedLabel = UILabel()
    var lineSeparator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        backgroundColor = .white
        prepareContainerView()
        prepareLineSeparator()
        prepareUnpublishedLabel()
        prepareProjectTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Other setups
    }
    
    func configure(with viewModel: ProjectLibraryViewModel, forRowAtIndexPath indexPath: IndexPath) {
        projectTitleLabel.text = viewModel.projectTitleAt(indexPath: indexPath)
        unpublishedLabel.text = "Unpublished"
    }
    
    private func prepareContainerView() {
        
        let width = frame.width * 0.9
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let containerViewFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        // containerView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        containerView.backgroundColor = .white
        
        addSubview(containerView)
    }
    
    private func prepareLineSeparator() {
        
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let lineSeparatorFrame = CGRect(x: maxX, y: 0, width: 1, height: height)
        lineSeparator.frame = lineSeparatorFrame
        lineSeparator.backgroundColor = UIColor(colorLiteralRed: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        
        addSubview(lineSeparator)
    }
    
    private func prepareProjectTitleLabel() {
        
        let width = frame.width * 0.9
        let height = frame.width * 0.3
        
        let projectTitleFrame = CGRect(x: 0, y: 0, width: width, height: height)
        projectTitleLabel.frame = projectTitleFrame
        
        projectTitleLabel.text = "3D Printed Gearbox"
        projectTitleLabel.font = UIFont(name: "Averta-Bold", size: frame.width * 0.06)
        projectTitleLabel.textColor = .black
        
        addSubview(projectTitleLabel)
        
        projectTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineSeparator.snp.right).offset(10)
            make.bottom.equalTo(unpublishedLabel.snp.top).offset(-2)
        }
    }
    
    private func prepareUnpublishedLabel() {
        
        let width = frame.width * 0.9
        let height = frame.width * 0.3
        
        let maxY = containerView.frame.height * 0.2
        
        let unpublishedLabelFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        unpublishedLabel.frame = unpublishedLabelFrame
        
        unpublishedLabel.text = "Unpublished"
        unpublishedLabel.font = UIFont(name: "Avenir-Medium", size: frame.width * 0.03)
        unpublishedLabel.textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        addSubview(unpublishedLabel)
        
        unpublishedLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineSeparator.snp.right).offset(10)
            make.bottom.equalTo(-2)
        }
    }
}
