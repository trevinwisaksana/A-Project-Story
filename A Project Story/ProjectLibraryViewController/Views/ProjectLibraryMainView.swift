//
//  ProjectLibraryMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/5/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit


///////////////////////////////
// Project Library Main View //
///////////////////////////////

final class ProjectLibraryMainView: UIView {
    
    var addProjectButton: UIButton!
    var projectLibraryCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Other setups
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setScreenSize()
        prepareAddProjectButton()
        prepareCollectionView()
    }
    
    // Only for PDD
    private func setScreenSize() {
        let screenSize = UIScreen.main.bounds.size
        frame.size = screenSize
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    private func prepareCollectionView() {
        
        let width = frame.width
        let height = frame.height
        
        let maxY = frame.maxY * 0.07
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        projectLibraryCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        projectLibraryCollectionView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        addSubview(projectLibraryCollectionView)
        
        projectLibraryCollectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(addProjectButton).offset(40)
        }
    }
    
    private func prepareAddProjectButton() {
        
        let height = frame.height * 0.04
        
        let maxX = frame.maxX * 0.05
        let maxY = frame.maxY * 0.03
        
        let buttonFrame = CGRect(x: maxX, y: maxY, width: height, height: height)
        addProjectButton = UIButton(frame: buttonFrame)
        
        let addProjectImage = UIImage(named: "addProjectButtonImage")
        addProjectButton.setImage(addProjectImage, for: .normal)
        
        addSubview(addProjectButton)
        
        addProjectButton.snp.makeConstraints { (make) in
            make.leading.top.equalTo(22)
        }
    }
    
}

