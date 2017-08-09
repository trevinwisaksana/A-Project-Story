//
//  StepCell.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class StepCell: UICollectionViewCell {
    
    var containerView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        prepareContainerView()
    }
    
    private func prepareContainerView() {
        
        let width = frame.width
        let height = frame.height
        
        let containerViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        containerView.backgroundColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        containerView.layer.cornerRadius = 10
        
        addSubview(containerView)
    }
    
    func configure() {
        
    }
    
}
