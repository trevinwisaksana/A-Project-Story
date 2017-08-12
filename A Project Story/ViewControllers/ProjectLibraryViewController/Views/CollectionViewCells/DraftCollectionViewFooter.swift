//
//  DraftCollectionViewFooter.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/9/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class DraftCollectionViewFooter: UICollectionReusableView {
    
    var showMoreButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareShowMoreButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareShowMoreButton() {
        
        let width = frame.width * 0.3
        let height = frame.height 
        
        let showMoreButtonFrame = CGRect(x: 0, y: 0, width: width, height: height)
        showMoreButton.frame = showMoreButtonFrame
        
        showMoreButton.setTitle("Show more", for: .normal)
        showMoreButton.setTitle("Show less", for: .selected)
        
        let titleColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        showMoreButton.setTitleColor(titleColor, for: .normal)
        
        let titleFont = UIFont(name: "Avenir", size: frame.width * 0.04)
        showMoreButton.titleLabel?.font = titleFont
        
        addSubview(showMoreButton)
    }
    
}
