//
//  PublishedProjectDescriptionSection.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class PublishedProjectDescriptionSection: UICollectionReusableView {
    
    var projectDescriptionTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        prepareProjectDescriptionTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareProjectDescriptionTextView() {
        
        let width = frame.width * 0.88
        let height = frame.height
        
        let artworkFrame = CGRect(x: 0, y: 0, width: width, height: height)
        projectDescriptionTextView.frame = artworkFrame
        projectDescriptionTextView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        addSubview(projectDescriptionTextView)
        
        projectDescriptionTextView.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.right.equalTo(-22)
            make.top.bottom.equalTo(22)
            make.width.equalTo(width)
        }
    }
    
}
