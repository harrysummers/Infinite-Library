//
//  LibraryDownloaderView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/21/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LibraryDownloaderView: UIView {
    weak var viewController: LibraryDownloadViewController? {
        didSet {
            setupViewController()
        }
    }
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Download your existing library"
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 3
        return label
    }()
    var downloadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        return button
    }()
    var skipButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyLight
        button.tintColor = .white
        return button
    }()
    var buttonStack: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15.0
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.contentMode = .center
        return stackView
    }()
    lazy var activityView: NVActivityIndicatorView = {
        var activityView = NVActivityIndicatorView(frame: CGRect.zero,
                                                   type: .ballPulse,
                                                   color: UIColor.CustomColors.offWhite,
                                                   padding: nil)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    var progressLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColors.offWhite
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    private func setupView() {
        setupTitleLabel()
        setupActivityView()
        setupButtonStack()
        setupProgressLabel()
    }
    fileprivate func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    fileprivate func setupActivityView() {
        addSubview(activityView)
        activityView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    fileprivate func setupButtonStack() {
        addSubview(buttonStack)
        buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.0).isActive = true
        buttonStack.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: 115).isActive = true
        buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonStack.addArrangedSubview(skipButton)
        buttonStack.addArrangedSubview(downloadButton)
    }
    fileprivate func setupProgressLabel() {
        addSubview(progressLabel)
        progressLabel.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -15.0).isActive = true
        progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        progressLabel.center = center
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
