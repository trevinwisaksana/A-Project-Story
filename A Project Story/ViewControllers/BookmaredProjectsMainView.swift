//
//  BookmaredProjectsMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

final class BookmarkedProjectsMainView: UIView {
    
    let searchTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScreenSize() {
        let screenSize = UIScreen.main.bounds.size
        frame.size = screenSize
        roundCorners([.topLeft, .topRight], radius: 10)
        backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
    }
    
    private func prepareSearchTextField() {
        
    }
    
}
