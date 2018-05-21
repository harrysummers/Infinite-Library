//
//  AddAlbumView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class AddAlbumView: UIView {

    weak var viewController: UIViewController? {
        didSet {
            setupViewController()
        }
    }
    var albumArt: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.CustomColors.spotifyDark
        return imageView
    }()
    var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = label.font.withSize(20.0)
        return label
    }()
    var artistLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = label.font.withSize(18.0)
        return label
    }()
    
    var addButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 15.0
        return button
    }()
    
    var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30.0
        view.backgroundColor = UIColor.CustomColors.spotifyLight
        return view
    }()
    var backgroundView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 1.0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    fileprivate func setupView() {
        setupContainerView()
        setupBackgroundView()
        setupAlbumArt()
        setupNameLabel()
        setupArtistLabel()
        setupAddButton()
    }
    
    fileprivate func setupContainerView() {
        addSubview(containerView)
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.0).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }
    fileprivate func setupBackgroundView() {
        addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    }
    fileprivate func setupAlbumArt() {
        containerView.addSubview(albumArt)
        albumArt.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20.0).isActive = true
        albumArt.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        albumArt.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        albumArt.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
    }
    
    fileprivate func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: albumArt.bottomAnchor, constant: 15.0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
    
    fileprivate func setupArtistLabel() {
        containerView.addSubview(artistLabel)
        artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
    fileprivate func setupAddButton() {
        containerView.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 15.0).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
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
