//
//  ArtworkSection.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/10/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class ArtworkSection: UICollectionReusableView {
    
    var artworkImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        prepareArtworkImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Other setup
    }
    
    func configure(with data: Project) {
        
    }
    
    private func prepareArtworkImageView() {
        
        let width = frame.width
        let height = frame.height
        
        let artworkFrame = CGRect(x: 0, y: 0, width: width, height: height)
        artworkImageView.frame = artworkFrame
        
        addSubview(artworkImageView)
    }
}
