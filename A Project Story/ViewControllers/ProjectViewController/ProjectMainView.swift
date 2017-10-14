//
//  ProjectMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/5/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class ProjectMainView: UIView {
    
    // Back button
    var backButton = UIButton()
    var publishedProjectsCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        
        preparePublishedProjectsCollectionView()
        prepareBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    private func setScreenSize() {
        frame.size = UIScreen.main.bounds.size
        backgroundColor = .black
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
    
    private func preparePublishedProjectsCollectionView() {
        
        let width = frame.width
        let height = frame.height
        
        let maxY = frame.maxY * 0.15
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        publishedProjectsCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        publishedProjectsCollectionView.backgroundColor = .clear
        publishedProjectsCollectionView.showsVerticalScrollIndicator = false
        
        publishedProjectsCollectionView.roundCorners([.topLeft, .topRight], radius: 10)
        
        addSubview(publishedProjectsCollectionView)
        
        publishedProjectsCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
}
