//
//  ProjectDescriptionSection.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/10/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

final class ProjectDescriptionSection: UICollectionReusableView {
    
    var projectDescriptionTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
        
        addSubview(projectDescriptionTextView)
        
        projectDescriptionTextView.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.right.equalTo(-22)
            make.top.bottom.equalTo(0)
            make.width.equalTo(width)
        }
    }
    
}
