//
//  StepsSection.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/14/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class StepSection: UICollectionReusableView {
    
    var publishStepCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: Project) {
        
    }
    
    private func preparePublishStepCollectionView() {
        
    }
    
}
