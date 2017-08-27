//
//  SearchedProjectCell.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/27/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class SearchedProjectCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        backgroundColor = .yellow
    }
    
}
