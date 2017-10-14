//
//  FeaturedCollectionViewCell.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/5/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

//////////////////////////
// Collection View Cell //
//////////////////////////

final class FeaturedCollectionViewCell: UICollectionViewCell {
    
    var containerView = UIView()
    var shadowBackground = UIView()
    var topTitleContainerView = UIView()
    var topTitleBlurView = UIVisualEffectView()
    var containerViewBackgroundImage = UIImageView()
    var categoryTitleLabel = UILabel()
    var projectTitleLabel = UILabel()
    var projectArtwork = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareShadowBackground()
        prepareContainerView()
        prepareContainerViewBackgroundImage()
        prepareProjectTitleLabel()
        prepareTopTitleContainerView()
        prepareTopTitleBlurView()
        prepareCategoryLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ProjectLibraryViewModel, forRowAtIndexPath indexPath: IndexPath) {
        projectTitleLabel.text = viewModel.projectTitleAt(indexPath: indexPath)
    }
    
    private func prepareShadowBackground() {
        
        let width = frame.width * 0.9
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let shadowBackgroundFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        shadowBackground.frame = shadowBackgroundFrame
        
        shadowBackground.layer.cornerRadius = 10
        shadowBackground.backgroundColor = .white
        shadowBackground.layer.opacity = 0.15
        shadowBackground.clipsToBounds = false
        
        shadowBackground.layer.shadowColor = UIColor.black.cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = CGSize.zero
        shadowBackground.layer.shadowRadius = 20
        shadowBackground.layer.shouldRasterize = true
        
        addSubview(shadowBackground)
    }
    
    private func prepareContainerView() {
        
        let width = frame.width * 0.9
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let containerViewFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        containerView.frame = containerViewFrame
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .white
        
        containerView.clipsToBounds = true
        
        addSubview(containerView)
    }
    
    private func prepareContainerViewBackgroundImage() {
        
        let width = containerView.frame.width
        let height = containerView.frame.height
        
        let containerViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        containerViewBackgroundImage.frame = containerViewFrame
        
        containerViewBackgroundImage.layer.cornerRadius = 10
        containerViewBackgroundImage.image = UIImage(named: "artworkImage_2")
        containerViewBackgroundImage.contentMode = .scaleAspectFill
        
        containerView.addSubview(containerViewBackgroundImage)
    }
    
    private func prepareTopTitleContainerView() {

        let width = projectTitleLabel.frame.width * 1.2
        let height = containerView.frame.height * 0.21
        
        let minX = containerView.frame.width * 0.05
        let minY = containerView.frame.height * 0.95 - height
        
        let containerViewFrame = CGRect(x: minX, y: minY, width: width, height: height)
        topTitleContainerView.frame = containerViewFrame
        topTitleContainerView.backgroundColor = .clear
        topTitleContainerView.layer.cornerRadius = 10
        topTitleContainerView.clipsToBounds = true
        
        containerView.addSubview(topTitleContainerView)
        containerView.bringSubview(toFront: projectTitleLabel)
    }
    
    private func prepareTopTitleBlurView() {
        let width = topTitleContainerView.frame.width
        let height = topTitleContainerView.frame.height
        
        let blurViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        topTitleBlurView.frame = blurViewFrame
        topTitleBlurView.effect = UIBlurEffect(style: .extraLight)
        
        topTitleContainerView.addSubview(topTitleBlurView)
    }
    
    private func prepareProjectTitleLabel() {
        
        projectTitleLabel.text = "3D Printed Water Bottle"
        projectTitleLabel.font = UIFont(name: "Avenir-Black", size: 20)
        projectTitleLabel.textColor = .black
        
        let width = projectTitleLabel.intrinsicContentSize.width
        let height = projectTitleLabel.intrinsicContentSize.height
        
        let minX = containerView.frame.width * 0.09
        let minY = containerView.frame.height * 0.86 - height
        
        let titleLabelFrame = CGRect(x: minX, y: minY, width: width, height: height)
        projectTitleLabel.frame = titleLabelFrame
        
        containerView.addSubview(projectTitleLabel)
    }
    
    private func prepareProjectArtwork() {
        
        
        
        addSubview(projectArtwork)
    }
    
    private func prepareCategoryLabel() {
        categoryTitleLabel.text = "TECH FOR GOOD"
        categoryTitleLabel.font = UIFont(name: "Avenir-Medium", size: 14)
        categoryTitleLabel.textColor = .gray
        
        let width = categoryTitleLabel.intrinsicContentSize.width
        let height = categoryTitleLabel.intrinsicContentSize.height
        
        let minX = containerView.frame.width * 0.09
        let minY = containerView.frame.height * 0.92 - height
        
        let titleLabelFrame = CGRect(x: minX, y: minY, width: width, height: height)
        categoryTitleLabel.frame = titleLabelFrame
        
        containerView.addSubview(categoryTitleLabel)
    }
}
