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
    
    var showMoreButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Other setup
        prepareShowMoreButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func prepareShowMoreButton() {
        
        let width = frame.width
        let height = frame.height 
        
        let showMoreButtonFrame = CGRect(x: 0, y: 0, width: width, height: height)
        showMoreButton.frame = showMoreButtonFrame
        
        let titleColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        showMoreButton.setTitleColor(titleColor, for: .normal)
        
        let titleFont = UIFont(name: "Avenir", size: frame.width * 0.04)
        showMoreButton.titleLabel?.font = titleFont
        showMoreButton.contentHorizontalAlignment = .left
        
        addSubview(showMoreButton)
        
        showMoreButton.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.top.bottom.equalTo(0)
        }
    }
    
    func hideShowMoreButton() {
        showMoreButton.alpha = 0
    }
    
    func unhideShowMoreButton() {
        showMoreButton.alpha = 1
    }
}
