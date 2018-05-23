//
//  AutoLoginView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/23/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AutoLoginView: UIView {
    weak var viewController: AutoLoginViewController? {
        didSet {
            setupViewController()
        }
    }
    lazy var activityView: NVActivityIndicatorView = {
        var activityView =
            NVActivityIndicatorView(frame: CGRect.zero,
                type: .ballPulse,
                color: UIColor.CustomColors.offWhite,
                padding: nil)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    var retryButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyLight
        button.tintColor = .white
        button.isHidden = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    fileprivate func setupView() {
        setupActivityView()
        setupRetryButton()
    }
    fileprivate func setupActivityView() {
        addSubview(activityView)
        activityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    fileprivate func setupRetryButton() {
        addSubview(retryButton)
        retryButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        retryButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        retryButton.topAnchor.constraint(equalTo: activityView.bottomAnchor, constant: 15).isActive = true
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    fileprivate func setupViewController() {
        if let view = viewController?.view {
            view.addSubview(self)
            leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
