//
//  AddAlbumViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import AlamofireImage

class AddAlbumViewController: UIViewController {

    let addAlbumView: AddAlbumView = {
        let view = AddAlbumView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var album: JSONAlbum?
    var albumDownloader: AlbumDownloader?
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .addAlbumViewController)
        guard let album = album else { return }
        setupViewController()
        setupBackground()
        setupAlbumView(with: album)
        buzz()
    }
    
    deinit {
        MemoryCounter.shared.decrementCount(for: .addAlbumViewController)
    }
    
    fileprivate func buzz() {
        impact.impactOccurred()
    }
    
    fileprivate func setupViewController() {
        addAlbumView.viewController = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTouched))
        addAlbumView.backgroundView.addGestureRecognizer(gestureRecognizer)
        addAlbumView.addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    fileprivate func setupBackground() {
        let darkColor = UIColor.CustomColors.spotifyLight
        view.backgroundColor = darkColor.withAlphaComponent(0.0)
    }
    
    fileprivate func setupAlbumView(with album: JSONAlbum) {
        setupAlbumArt(album)
        setupNameLabel(album)
        setupArtistLabel(album)
    }
    
    fileprivate func setupAlbumArt(_ album: JSONAlbum) {
        if let images = album.images, images.count > 0, let url = URL(string: images[0].url) {
            addAlbumView.albumArt.af_setImage(withURL: url)
        }
    }
    
    fileprivate func setupNameLabel(_ album: JSONAlbum) {
        addAlbumView.nameLabel.text = album.name ?? ""
    }
    
    fileprivate func setupArtistLabel(_ album: JSONAlbum) {
        addAlbumView.artistLabel.text = album.artists?[0].name ?? ""
    }
    
    @objc func backgroundTouched() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonPressed() {
        guard let albumDownloader = albumDownloader else { return }
        buzz()
        saveAlbum(albumDownloader)
    }
    
    fileprivate func saveAlbum(_ albumDownloader: AlbumDownloader) {
        weak var weakSelf = self
        albumDownloader.saveToDatabase {
            albumDownloader.getArt()
            weakSelf?.dismiss(animated: true, completion: nil)
        }
    }
}
