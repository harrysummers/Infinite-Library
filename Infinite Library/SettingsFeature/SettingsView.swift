//
//  SettingsView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    weak var viewController: SettingsViewController? {
        didSet {
            setupViewController()
        }
    }
    var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bounces = true
        scroll.isScrollEnabled = true
        scroll.delaysContentTouches = false
        scroll.backgroundColor = UIColor.CustomColors.spotifyDark
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    var contentView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColors.offWhite
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.text = "Settings"
        return label
    }()
    var closeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.CustomColors.offWhite
        button.setTitle("Close", for: .normal)
        return button
    }()
    var logoutButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        button.setTitle("Log Out", for: .normal)
        button.layer.cornerRadius = 18.0
        return button
    }()
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 250)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: "gifCell")
        collection.backgroundColor = UIColor.CustomColors.spotifyDark
        collection.bounces = true
        collection.alwaysBounceHorizontal = true
        collection.alwaysBounceVertical = false
        return collection
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    fileprivate func setupView() {
        setupScrollView()
        setupContentView()
        setupTitleLabel()
        setupCloseButton()
        setupCollectionView()
        setupLogoutButton()
    }
    fileprivate func setupScrollView() {
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    fileprivate func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
    }
    fileprivate func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
    }
    fileprivate func setupCloseButton() {
        contentView.addSubview(closeButton)
        closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
    fileprivate func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15.0).isActive = true
    }
    fileprivate func setupLogoutButton() {
        contentView.addSubview(logoutButton)
        logoutButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
