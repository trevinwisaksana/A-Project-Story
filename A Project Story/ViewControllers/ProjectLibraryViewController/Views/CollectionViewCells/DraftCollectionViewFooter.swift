//
//  DraftCollectionViewFooter.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/9/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

final class DraftCollectionViewFooter: UICollectionReusableView {
    
    var showMoreButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Other setup
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareShowMoreButton()
    }
    
    private func prepareShowMoreButton() {
        
        let width = frame.width * 0.3
        let height = frame.height 
        
        let showMoreButtonFrame = CGRect(x: 0, y: 0, width: width, height: height)
        showMoreButton.frame = showMoreButtonFrame
        
        showMoreButton.setTitle("Show more", for: .normal)
        
        let titleColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        showMoreButton.setTitleColor(titleColor, for: .normal)
        
        let titleFont = UIFont(name: "Avenir", size: frame.width * 0.04)
        showMoreButton.titleLabel?.font = titleFont
        
        addSubview(showMoreButton)
        
        showMoreButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
    }
    
    func hideShowMoreButton() {
        showMoreButton.isHidden = true
    }
    
    func unhideShowMoreButton() {
        showMoreButton.isHidden = false
    }
    
}
