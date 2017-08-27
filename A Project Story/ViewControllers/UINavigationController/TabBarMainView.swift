//
//  TabBarMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/19/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

final class TabBarMainView: UIView {
    
    let contentView = UIView()
    let tabBarView = UIView()
    let tabBarStackView = UIStackView()
    let topLineBorder = UIView()
    let projectLibraryButton = UIButton()
    let searchButton = UIButton()
    let updateProjectButton = UIButton()
    let bookmarkedProjectsButton = UIButton()
    let profileButton = UIButton()
    var listOfButtons = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        
        prepareContentView()
        prepareTabBarView()
        prepareTabBarStackView()
        // prepareTopLineBorder()
        prepareProjectLibraryButton()
        prepareSearchButton()
        prepareUpdateProjectButton()
        prepareBookmarkedProjectButton()
        prepareProfileButton()
        appendButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScreenSize() {
        frame.size = UIScreen.main.bounds.size
        roundCorners([.topLeft, .topRight], radius: 10)
        backgroundColor = .clear
    }
    
    private func prepareContentView() {
        let width = frame.width
        let height = frame.height * 0.93
        
        let contentViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        contentView.frame = contentViewFrame
        contentView.layer.cornerRadius = 10
        
        let backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        contentView.backgroundColor = backgroundColor
        
        addSubview(contentView)
        sendSubview(toBack: contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.left.right.equalTo(0)
            make.top.equalTo(0)
        }
    }
    
    private func prepareTabBarView() {
        let width = frame.width
        let height = frame.height * 0.07
        
        let maxY = frame.maxY * 0.9
        
        let tabBarViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        tabBarView.frame = tabBarViewFrame
        
        // let backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.97)
        tabBarView.backgroundColor = .black
        
        addSubview(tabBarView)
        bringSubview(toFront: tabBarView)
        
        tabBarView.snp.makeConstraints { (make) in
            make.height.equalTo(height)
            make.width.equalTo(width)
            make.bottom.left.right.equalTo(0)
        }
    }
    
    private func prepareTabBarStackView() {
        let width = frame.width * 0.8
        let height = frame.height * 0.1
        
        let stackViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        tabBarStackView.frame = stackViewFrame
        
        // let backgroundColor = UIColor(colorLiteralRed: 83/255, green: 88/255, blue: 95/255, alpha: 1)
        tabBarStackView.backgroundColor = .black
        
        tabBarStackView.axis = .horizontal
        tabBarStackView.spacing = width * 0
        tabBarStackView.distribution = .fillEqually
        tabBarStackView.alignment = .center
        tabBarStackView.contentMode = .scaleAspectFit
        tabBarStackView.translatesAutoresizingMaskIntoConstraints = false
        
        tabBarView.addSubview(tabBarStackView)
        
        tabBarStackView.snp.makeConstraints { (make) in
            make.left.equalTo(width * 0)
            make.right.equalTo(-width * 0)
            make.top.equalTo(height * 0.19)
            make.bottom.equalTo(-height * 0.19)
        }
    }
    
    private func prepareTopLineBorder() {
    
        let width = frame.width
        
        let topLineBorderFrame = CGRect(x: 0, y: 0, width: width, height: 1)
        topLineBorder.frame = topLineBorderFrame
        
        topLineBorder.backgroundColor = UIColor(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        tabBarView.addSubview(topLineBorder)
    }
    
    private func prepareProjectLibraryButton() {
        let width = frame.width * 0.12
        
        let buttonFrame = CGRect(x: 0, y: 0, width: width, height: width)
        projectLibraryButton.frame = buttonFrame
        
        let buttonImage = UIImage(named: "projectLibraryButtonIcon_white")
        let selectedButtonImage = UIImage(named: "projectLibraryButtonIcon_white_selected")
        projectLibraryButton.setImage(buttonImage, for: .normal)
        projectLibraryButton.setImage(selectedButtonImage, for: .selected)
        projectLibraryButton.imageView?.contentMode = .scaleAspectFit
        projectLibraryButton.tag = 0
        
        tabBarStackView.addArrangedSubview(projectLibraryButton)
        
        projectLibraryButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
        }
    }
    
    private func prepareSearchButton() {
        let width = frame.width * 0.09
        
        let buttonFrame = CGRect(x: 0, y: 0, width: width, height: width)
        searchButton.frame = buttonFrame
        
        let buttonImage = UIImage(named: "searchButtonIcon")
        let selectedButtonImage = UIImage(named: "searchButtonIcon_selected")
        searchButton.setImage(buttonImage, for: .normal)
        searchButton.setImage(selectedButtonImage, for: .selected)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.tag = 1
        
        tabBarStackView.addArrangedSubview(searchButton)
        
        searchButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
        }
    }
    
    private func prepareUpdateProjectButton() {
        let width = frame.width * 0.15
        
        let buttonFrame = CGRect(x: 0, y: 0, width: width, height: width)
        updateProjectButton.frame = buttonFrame
        
        let buttonImage = UIImage(named: "updateProjectButtonIcon")
        let selectedButtonImage = UIImage(named: "updateProjectButtonIcon_selected")
        updateProjectButton.setImage(buttonImage, for: .normal)
        updateProjectButton.setImage(selectedButtonImage, for: .selected)
        updateProjectButton.imageView?.contentMode = .scaleAspectFit
        updateProjectButton.tag = 2
        
        tabBarStackView.addArrangedSubview(updateProjectButton)
        
        updateProjectButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
        }
    }
    
    private func prepareBookmarkedProjectButton() {
        let width = frame.width * 0.12
        
        let buttonFrame = CGRect(x: 0, y: 0, width: width, height: width)
        bookmarkedProjectsButton.frame = buttonFrame
        
        let buttonImage = UIImage(named: "bookmarkedProjectButtonIcon")
        let selectedButtonImage = UIImage(named: "bookmarkedProjectButtonIcon_selected")
        bookmarkedProjectsButton.setImage(buttonImage, for: .normal)
        bookmarkedProjectsButton.setImage(selectedButtonImage, for: .selected)
        bookmarkedProjectsButton.imageView?.contentMode = .scaleAspectFit
        bookmarkedProjectsButton.tag = 3
        
        tabBarStackView.addArrangedSubview(bookmarkedProjectsButton)
        
        bookmarkedProjectsButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
        }
    }
    
    private func prepareProfileButton() {
        let width = frame.width * 0.1
        
        let buttonFrame = CGRect(x: 0, y: 0, width: width, height: width)
        profileButton.frame = buttonFrame
        
        let buttonImage = UIImage(named: "profileButtonIcon")
        let selectedButtonImage = UIImage(named: "profileButtonIcon_selected")
        profileButton.setImage(buttonImage, for: .normal)
        profileButton.setImage(selectedButtonImage, for: .selected)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.tag = 4
        
        tabBarStackView.addArrangedSubview(profileButton)
        
        profileButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
        }
    }
    
    private func appendButtons() {
        let buttons = [projectLibraryButton, searchButton, updateProjectButton, bookmarkedProjectsButton, profileButton]
        listOfButtons.append(contentsOf: buttons)
    }
}
