//
//  SettingsViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/16/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SpotifyLogin

class SettingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        var collection = UICollectionView()
        collection.backgroundColor = .red
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func closePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func logoutPressed() {
        
        // Ask the user are they sure
        SpotifyLogin.shared.logout()
        let vc = LoginViewController()
        present(vc, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        
        contentView.addSubview(closeButton)
        closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        closeButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)

        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15.0).isActive = true
        
        contentView.addSubview(logoutButton)
        logoutButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
    }
    
    
    
}
