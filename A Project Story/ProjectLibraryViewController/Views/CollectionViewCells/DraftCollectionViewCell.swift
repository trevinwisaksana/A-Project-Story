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
    var projectArtwork = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        prepareContainerView()
    }
    
    func configure(with viewModel: ProjectLibraryViewModel, forRowAtIndexPath indexPath: IndexPath) {
        projectTitleLabel.text = viewModel.projectTitleAt(indexPath: indexPath)
    }
    
    private func prepareContainerView() {
        
        let width = frame.width * 0.9
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let containerViewFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .green
        
        addSubview(containerView)
    }
    
}

