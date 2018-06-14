//
//  TutorialScreenView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/20/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class TutorialScreenView: UIView {
    weak var viewController: TutorialScreenViewController? {
        didSet {
            setupViewController()
        }
    }
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 3
        return label
    }()
    var nextButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        return button
    }()
    var gifView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.CustomColors.spotifyDark
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    fileprivate func setupView() {
        setupTitleLabel()
        setupNextButton()
        setupGifView()
    }
    fileprivate func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    fileprivate func setupNextButton() {
        addSubview(nextButton)
        nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.0).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    fileprivate func setupGifView() {
        addSubview(gifView)
        gifView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        gifView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gifView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -40).isActive = true
        //gifView.widthAnchor.constraint(equalToConstant: 140).isActive = true
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
