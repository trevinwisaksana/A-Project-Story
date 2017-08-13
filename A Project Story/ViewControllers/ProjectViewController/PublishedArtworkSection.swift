//
//  PublishedArtworkSection.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/13/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class PublishedArtworkSection: UICollectionReusableView {
    
    var artworkImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        prepareArtworkImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareArtworkImageView() {
        
        let width = frame.width
        let height = frame.height
        
        let artworkFrame = CGRect(x: 0, y: 0, width: width, height: height)
        artworkImageView.frame = artworkFrame
        
        addSubview(artworkImageView)
    }
    
}
