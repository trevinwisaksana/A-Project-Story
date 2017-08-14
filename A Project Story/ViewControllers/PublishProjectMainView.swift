//
//  PublishProjectMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/8/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class PublishProjectMainView: UIView {
    
    // Back button
    var backButton = UIButton()
    var publishButton = UIButton()
    var publishCollectionView: UICollectionView!
    
    // Image View
    var artworkImageView = UIImageView()
    
    // Text View
    var descriptionTextView = UITextView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        
        preparePublishCollectionView()
        prepareBackButton()
        preparePublishButton()
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
    
    private func preparePublishButton() {
        
        let width = frame.width * 0.2
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.75
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: width, height: height)
        publishButton.frame = buttonFrame
        
        publishButton.setTitle("Publish", for: .normal)
        
        let fontColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        publishButton.setTitleColor(fontColor, for: .normal)
        
        let buttonFont = UIFont(name: "Avenir", size: frame.width * 0.05)
        publishButton.titleLabel?.font = buttonFont
        
        addSubview(publishButton)
        
        publishButton.snp.makeConstraints { (make) in
            make.top.equalTo(17)
            make.right.equalTo(-22)
        }
    }
    
    private func preparePublishCollectionView() {
        
        let width = frame.width
        let height = frame.height * 0.8
        
        let maxY = frame.maxY * 0.15
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        publishCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        publishCollectionView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        publishCollectionView.showsVerticalScrollIndicator = false
        publishCollectionView.alwaysBounceVertical = true
        
        addSubview(publishCollectionView)
        
        publishCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.leading.trailing.top.bottom.equalTo(0)
        }
    }
    
}
