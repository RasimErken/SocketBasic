//
//  Activity Indicator.swift
//  socketBasic
//
//  Created by rasim rifat erken on 20.10.2022.
//  Copyright © 2022 mac-0005. All rights reserved.
//


import UIKit

class ActivityIndicator {

    static let sharedIndicator = ActivityIndicator()
    private var spinnerView = UIView()

    func showLoadingIndicator(onView: UIView) {
        spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            _self.spinnerView.addSubview(activityIndicator)
            onView.addSubview(_self.spinnerView)
        }
    }

    func hideLoadingIndicator() {
        DispatchQueue.main.async {[weak self] in
            guard let _self = self else { return }
            _self.spinnerView.removeFromSuperview()
        }
    }
}


