//
//  UIView + LoadingIndicator.swift
//  A Project Story
//
//  Created by Trevin Wisaksana on 8/26/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//

import UIKit

extension UIView {
    
    func showActivityIndicator(for loadingView: UIView, in superview: UIView, with spinner: UIActivityIndicatorView) {
        DispatchQueue.main.async() {
            loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            loadingView.center = superview.center
            loadingView.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
            loadingView.alpha = 0.7
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
    
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            spinner.center = CGPoint(x: loadingView.bounds.size.width / 2, y: loadingView.bounds.size.height / 2)
            
            loadingView.addSubview(spinner)
            superview.addSubview(loadingView)
            spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator(for loadingView: UIView, with spinner: UIActivityIndicatorView) {
        DispatchQueue.main.async() {
            spinner.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
    
}
