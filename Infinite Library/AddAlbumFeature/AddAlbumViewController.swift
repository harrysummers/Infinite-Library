//
//  AddAlbumViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class AddAlbumViewController: UIViewController {

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
        label.font = label.font.withSize(16.0)
        return label
    }()
    
    var addButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 10.0
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
    
    var album: JSONAlbum?
    var albumDownloader: AlbumDownloader?
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let darkColor = UIColor.CustomColors.spotifyLight
        view.backgroundColor = darkColor.withAlphaComponent(0.0)
        setupView()
        if let album = album {
            setupAlbumView(with: album)
        }
        impact.impactOccurred()
    }
    
    
    private func setupAlbumView(with album: JSONAlbum) {
        if let images = album.images, images.count > 0, let url = URL(string: images[0].url) {
                       albumArt.af_setImage(withURL: url)
        }
        nameLabel.text = album.name ?? ""
        artistLabel.text = album.artists?[0].name ?? ""
        
        
    }
    
    @objc func backgroundTouched() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonPressed() {
        if let albumDownloader = albumDownloader {
            impact.impactOccurred()
            albumDownloader.saveToDatabase {
                albumDownloader.getArt()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func setupView() {
        
        view.addSubview(containerView)
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15.0).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        
        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTouched))
        backgroundView.addGestureRecognizer(gestureRecognizer)
        
        containerView.addSubview(albumArt)
        albumArt.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20.0).isActive = true
        albumArt.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        albumArt.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        albumArt.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        containerView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: albumArt.bottomAnchor, constant: 15.0).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        containerView.addSubview(artistLabel)
        artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        containerView.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 15.0).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }

}
