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
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        prepareProjectDescriptionTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let placeholderText = "Please enter your project description here..."
        if projectDescriptionTextView.text == placeholderText {
            projectDescriptionTextView.textColor = .lightGray
        }
    }
    
    func configure(with data: Project) {
        // Data description is empty
        if data.description.isEmpty {
            data.description = "Please enter your project description here..."
            projectDescriptionTextView.textColor = .lightGray
        }
        
        projectDescriptionTextView.text = data.description
    }
    
    private func prepareProjectDescriptionTextView() {
        
        let width = frame.width * 0.88
        let height = frame.height
        
        let artworkFrame = CGRect(x: 0, y: 0, width: width, height: height)
        projectDescriptionTextView.frame = artworkFrame
        projectDescriptionTextView.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        
        projectDescriptionTextView.font = UIFont(name: "Avenir-Medium", size: width * 0.045)
        
        addSubview(projectDescriptionTextView)
        
        projectDescriptionTextView.snp.makeConstraints { (make) in
            make.left.equalTo(21)
            make.right.equalTo(-21)
            make.top.equalTo(10)
            make.bottom.equalTo(0)
            make.width.equalTo(width)
        }
    }
    
}
