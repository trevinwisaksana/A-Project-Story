//
//  SearchMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

final class SearchMainView: UIView {
    
    let searchTextField = UITextField()
    var searchedProjectCollectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        prepareSearchTextField()
        prepareSearchCollectionView()
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
        let textFieldWidth: CGFloat = frame.width * 0.8
        let textFieldHeight: CGFloat = frame.height * 0.08
        
        let textFieldFrame = CGRect(x: frame.width * 0.05, y: 0, width: textFieldWidth, height: textFieldHeight)
        searchTextField.frame = textFieldFrame
        
        searchTextField.placeholder = "Search"
        searchTextField.font = UIFont(name: "Avenir", size: 20)
        
        addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(frame.width * 0.07)
            make.right.equalTo(-frame.width * 0.07)
            make.top.equalTo(5)
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(textFieldWidth)
        }
    }
    
    private func prepareSearchCollectionView() {
        let width = frame.width
        let height = frame.height * 0.8
        
        let maxY = frame.maxY * 0.15
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        searchedProjectCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        searchedProjectCollectionView?.backgroundColor = .clear
        searchedProjectCollectionView?.showsVerticalScrollIndicator = false
        
        guard let collectionView = searchedProjectCollectionView else {
            return
        }
        
        addSubview(collectionView)
        
        searchedProjectCollectionView?.snp.makeConstraints { (make) in
            make.width.equalTo(self.frame.width)
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(searchTextField.frame.maxY)
        }
    }
    
    func registerCollectionViewCell() {
        searchedProjectCollectionView?.register(SearchedProjectCell.self, forCellWithReuseIdentifier: "SearchedProjectCell")
    }
    
}
