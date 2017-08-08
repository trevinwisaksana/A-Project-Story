//
//  ProjectLibraryReusableView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/6/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

///////////////////
// Reusable View //
///////////////////

final class ProjectLibraryReusableView: UICollectionReusableView {
    
    var sectionTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSectionTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSectionTitle() {
        
        let width = frame.width
        let height = frame.height
        
        let maxX = frame.maxX * 0.05
        
        let sectionTitleFrame = CGRect(x: maxX, y: 0, width: width, height: height)
        sectionTitleLabel.frame = sectionTitleFrame
        
        sectionTitleLabel.text = "Featured"
        
        let titleFont = UIFont(name: "Averta-Bold", size: frame.width * 0.09)
        sectionTitleLabel.font = titleFont
        
        addSubview(sectionTitleLabel)
    }
}

