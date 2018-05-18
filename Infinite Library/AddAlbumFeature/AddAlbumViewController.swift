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
        let darkColor = UIColor.CustomColors.spotifyLight
        view.backgroundColor = darkColor.withAlphaComponent(0.0)
        if let album = album {
            setupAlbumView(with: album)
        }
        impact.impactOccurred()
        addAlbumView.viewController = self
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTouched))
        addAlbumView.backgroundView.addGestureRecognizer(gestureRecognizer)
        addAlbumView.addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    
    private func setupAlbumView(with album: JSONAlbum) {
        if let images = album.images, images.count > 0, let url = URL(string: images[0].url) {
                       addAlbumView.albumArt.af_setImage(withURL: url)
        }
        addAlbumView.nameLabel.text = album.name ?? ""
        addAlbumView.artistLabel.text = album.artists?[0].name ?? ""   
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

}
