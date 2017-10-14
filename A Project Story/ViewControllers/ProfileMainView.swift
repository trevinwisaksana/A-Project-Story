//
//  ProfileMainView.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/20/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileMainView: UIView {
    
    let topHeaderPhoto = UIImageView()
    let profilePhoto = UIImageView()
    let userNameLabel = UILabel()
    let userLocationLabel = UILabel()
    //
    let topLineSeparator = UIView()
    //
    let userStatisticsStackView = UIStackView()
    let numberOfProjectsStackView = UIStackView()
    let numberOfProjectsLabel = UILabel()
    let projectTitleLabel = UILabel()
    //
    let numberOfFollowingStackView = UIStackView()
    let numberOfFollowingLabel = UILabel()
    let followingTitleLabel = UILabel()
    //
    let numberOfFollowersStackView = UIStackView()
    let numberOfFollowersLabel = UILabel()
    let followersTitleLabel = UILabel()
    //
    let bottomLineSeparator = UIView()
    //
    var profileCollectionView: UICollectionView?
    // Loading Indicator
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setScreenSize()
        
        prepareTopHeaderPhoto()
        prepareProfilePhoto()
        prepareUserNameLabel()
        prepareUserLocationLabel()
        prepareTopLineSeparator()
        //
        prepareUserStatisticStackView()
        prepareNumberOfProjectsStackView()
        prepareNumberOfFollowersStackView()
        prepareNumberOfFollowingStackView()
        //
        prepareNumberOfProjectsLabel()
        prepareProjectTitleLabel()
        prepareNumberOfFollowingLabel()
        prepareFollowingTitleLabel()
        prepareNumberOfFollowersLabel()
        prepareFollowersTitleLabel()
        //
        prepareBottomLineSeparator()
        //
        prepareProfileCollectionView()
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
    
    private func prepareTopHeaderPhoto() {
        let width = frame.width
        let height = frame.height * 0.1
        
        let topHeaderPhotoFrame = CGRect(x: 0, y: 0, width: width, height: height)
        topHeaderPhoto.frame = topHeaderPhotoFrame
        topHeaderPhoto.backgroundColor = .yellow
        topHeaderPhoto.roundCorners([.topLeft, .topRight], radius: 10)
        
        addSubview(topHeaderPhoto)
        
        topHeaderPhoto.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareProfilePhoto() {
        let width = frame.width * 0.2
        
        let profilePhotoFrame = CGRect(x: 0, y: 0, width: width, height: width)
        profilePhoto.frame = profilePhotoFrame
        profilePhoto.backgroundColor = .blue
        profilePhoto.layer.cornerRadius = 10
        
        addSubview(profilePhoto)
        
        profilePhoto.snp.makeConstraints { (make) in
            make.left.equalTo(width * 0.25)
            make.top.equalTo(topHeaderPhoto.snp.top).offset(topHeaderPhoto.frame.midY)
            make.width.height.equalTo(width)
        }
    }
    
    private func prepareUserNameLabel() {
        let width = frame.width * 0.8
        let height = frame.height * 0.05
        
        let userNameLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        userNameLabel.frame = userNameLabelFrame
        userNameLabel.text = "Trevin Wisaksana"
        userNameLabel.font = UIFont(name: "Averta-Bold", size: 25)
        
        addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(frame.width * 0.25 * 0.25)
            make.top.equalTo(profilePhoto.snp.bottom).offset(18)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareUserLocationLabel() {
        let width = frame.width * 0.8
        let height = frame.height * 0.05
        
        let userLocationLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        userLocationLabel.frame = userLocationLabelFrame
        userLocationLabel.text = "Jakarta, Indonesia"
        userLocationLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        userLocationLabel.textColor = .lightGray
        
        addSubview(userLocationLabel)
        
        userLocationLabel.snp.makeConstraints { (make) in
            make.left.equalTo(frame.width * 0.25 * 0.25)
            make.top.equalTo(userNameLabel.snp.bottom).offset(-10)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareTopLineSeparator() {
        let width = frame.width * 0.88
        
        let maxX = frame.maxX * 0.05
        
        let topLineSeparatorFrame = CGRect(x: maxX, y: 0, width: width, height: 1)
        topLineSeparator.frame = topLineSeparatorFrame
        topLineSeparator.backgroundColor = UIColor(colorLiteralRed: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        
        addSubview(topLineSeparator)
        
        topLineSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(userLocationLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.width.equalTo(width)
            make.left.equalTo(22)
            make.right.equalTo(-22)
        }
    }
    
    private func prepareUserStatisticStackView() {
        let width = frame.width * 0.88
        let height = frame.height * 0.07
        
        let stackViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        userStatisticsStackView.frame = stackViewFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 83/255, green: 88/255, blue: 95/255, alpha: 1)
        userStatisticsStackView.backgroundColor = backgroundColor
        
        userStatisticsStackView.axis = .horizontal
        userStatisticsStackView.spacing = 30
        userStatisticsStackView.distribution = .fillEqually
        userStatisticsStackView.alignment = .center
        userStatisticsStackView.contentMode = .scaleAspectFit
        userStatisticsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userStatisticsStackView)
        
        userStatisticsStackView.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.right.equalTo(-22)
            make.top.equalTo(topLineSeparator.snp.bottom).offset(15)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareNumberOfProjectsStackView() {
        let width = frame.width * 0.2
        let height = frame.height * 0.07
        
        let stackViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        numberOfProjectsStackView.frame = stackViewFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 83/255, green: 88/255, blue: 95/255, alpha: 1)
        numberOfProjectsStackView.backgroundColor = backgroundColor
        
        numberOfProjectsStackView.axis = .vertical
        numberOfProjectsStackView.spacing = 0
        numberOfProjectsStackView.distribution = .fill
        numberOfProjectsStackView.alignment = .center
        numberOfProjectsStackView.contentMode = .scaleAspectFit
        numberOfProjectsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        userStatisticsStackView.addArrangedSubview(numberOfProjectsStackView)
        
        numberOfProjectsStackView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareNumberOfFollowersStackView() {
        let width = frame.width * 0.2
        let height = frame.height * 0.07
        
        let stackViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        numberOfFollowersStackView.frame = stackViewFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 83/255, green: 88/255, blue: 95/255, alpha: 1)
        numberOfFollowersStackView.backgroundColor = backgroundColor
        
        numberOfFollowersStackView.axis = .vertical
        numberOfFollowersStackView.spacing = 0
        numberOfFollowersStackView.distribution = .fill
        numberOfFollowersStackView.alignment = .center
        numberOfFollowersStackView.contentMode = .scaleAspectFit
        numberOfFollowersStackView.translatesAutoresizingMaskIntoConstraints = false
        
        userStatisticsStackView.addArrangedSubview(numberOfFollowersStackView)
        
        numberOfFollowersStackView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareNumberOfFollowingStackView() {
        let width = frame.width * 0.2
        let height = frame.height * 0.07
        
        let stackViewFrame = CGRect(x: 0, y: 0, width: width, height: height)
        numberOfFollowingStackView.frame = stackViewFrame
        
        let backgroundColor = UIColor(colorLiteralRed: 83/255, green: 88/255, blue: 95/255, alpha: 1)
        numberOfFollowingStackView.backgroundColor = backgroundColor
        
        numberOfFollowingStackView.axis = .vertical
        numberOfFollowingStackView.spacing = 0
        numberOfFollowingStackView.distribution = .fill
        numberOfFollowingStackView.alignment = .center
        numberOfFollowingStackView.contentMode = .scaleAspectFit
        numberOfFollowingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        userStatisticsStackView.addArrangedSubview(numberOfFollowingStackView)
        
        numberOfFollowingStackView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func prepareNumberOfProjectsLabel() {
        let width = frame.width * 0.2
        let height = frame.height * 0.03
        
        let numberOfProjectsLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        numberOfProjectsLabel.frame = numberOfProjectsLabelFrame
        numberOfProjectsLabel.text = "28"
        numberOfProjectsLabel.font = UIFont(name: "Averta-Semibold", size: 25)
        numberOfProjectsLabel.textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        numberOfProjectsStackView.addArrangedSubview(numberOfProjectsLabel)
    }
    
    private func prepareProjectTitleLabel() {
        let width = frame.width * 0.2
        let height = frame.height * 0.03
        
        let projectTitleLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        projectTitleLabel.frame = projectTitleLabelFrame
        projectTitleLabel.text = "Projects"
        projectTitleLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        projectTitleLabel.textColor = UIColor(colorLiteralRed: 135/255, green: 135/255, blue: 135/255, alpha: 1)
        
        numberOfProjectsStackView.addArrangedSubview(projectTitleLabel)
    }
    
    private func prepareNumberOfFollowingLabel() {
        let width = frame.width * 0.2
        let height = frame.height * 0.03
        
        let numberOfFollowingLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        numberOfFollowingLabel.frame = numberOfFollowingLabelFrame
        numberOfFollowingLabel.text = "11"
        numberOfFollowingLabel.font = UIFont(name: "Averta-Semibold", size: 25)
        numberOfFollowingLabel.textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        numberOfFollowingStackView.addArrangedSubview(numberOfFollowingLabel)
    }
    
    private func prepareFollowingTitleLabel() {
        let width = frame.width * 0.2
        let height = frame.height * 0.03
        
        let followingTitleLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        followingTitleLabel.frame = followingTitleLabelFrame
        followingTitleLabel.text = "Following"
        followingTitleLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        followingTitleLabel.textColor = UIColor(colorLiteralRed: 135/255, green: 135/255, blue: 135/255, alpha: 1)
        
        numberOfFollowingStackView.addArrangedSubview(followingTitleLabel)
    }
    
    private func prepareNumberOfFollowersLabel() {
        let width = frame.width * 0.2
        let height = frame.height * 0.03
        
        let numberOfFollowersLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        numberOfFollowersLabel.frame = numberOfFollowersLabelFrame
        numberOfFollowersLabel.text = "8"
        numberOfFollowersLabel.font = UIFont(name: "Averta-Semibold", size: 25)
        numberOfFollowersLabel.textColor = UIColor(colorLiteralRed: 249/255, green: 182/255, blue: 43/255, alpha: 1)
        
        numberOfFollowersStackView.addArrangedSubview(numberOfFollowersLabel)
    }
    
    private func prepareFollowersTitleLabel() {
        let width = frame.width * 0.2
        let height = frame.height * 0.03
        
        let followersTitleLabelFrame = CGRect(x: 0, y: 0, width: width, height: height)
        followersTitleLabel.frame = followersTitleLabelFrame
        followersTitleLabel.text = "Followers"
        followersTitleLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        followersTitleLabel.textColor = UIColor(colorLiteralRed: 135/255, green: 135/255, blue: 135/255, alpha: 1)
        
        numberOfFollowersStackView.addArrangedSubview(followersTitleLabel)
    }
    
    private func prepareBottomLineSeparator() {
        let width = frame.width * 0.88
        
        let maxX = frame.maxX * 0.05
        
        let bottomLineSeparatorFrame = CGRect(x: maxX, y: 0, width: width, height: 1)
        bottomLineSeparator.frame = bottomLineSeparatorFrame
        bottomLineSeparator.backgroundColor = UIColor(colorLiteralRed: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        
        addSubview(bottomLineSeparator)
        
        bottomLineSeparator.snp.makeConstraints { (make) in
            make.top.equalTo(userStatisticsStackView.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.width.equalTo(width)
            make.left.equalTo(22)
            make.right.equalTo(-22)
        }
    }
    
    private func prepareProfileCollectionView() {
        let width = frame.width
        let height = frame.height * 0.8
        
        let maxY = frame.maxY * 0.15
        
        let collectionViewFrame = CGRect(x: 0, y: maxY, width: width, height: height)
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        profileCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: collectionViewFlowLayout)
        profileCollectionView?.backgroundColor = UIColor(colorLiteralRed: 248/255, green: 253/255, blue: 253/255, alpha: 1)
        profileCollectionView?.showsVerticalScrollIndicator = false
        profileCollectionView?.alwaysBounceVertical = true
        
        guard let collectionView = profileCollectionView else {
            return
        }
        
        addSubview(collectionView)
        
        profileCollectionView?.snp.makeConstraints { (make) in
            make.width.equalTo(frame.width)
            make.left.equalTo(22)
            make.right.equalTo(-22)
            make.bottom.equalTo(0)
            make.top.equalTo(bottomLineSeparator.snp.bottom).offset(0)
        }
    }
    
    func registerCollectionViewCells() {
        profileCollectionView?.register(
            ProfileCollectionViewCell.self,
            forCellWithReuseIdentifier: "ProfileCell"
        )
    }
    
    func displayLoadingIndicator() {
        self.showActivityIndicator(for: loadingView, in: self, with: spinner)
    }
    
    func dismissLoadingIndicator() {
        self.hideActivityIndicator(for: loadingView, with: spinner)
    }
    
}
