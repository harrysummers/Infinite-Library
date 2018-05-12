//
//  AddAlbumViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class AddAlbumViewController: UIViewController {

//    var albumArt: UIImageView = {
//        var imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = UIColor.CustomColors.spotifyDark
//        return imageView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let darkColor = UIColor.CustomColors.spotifyDark
        view.backgroundColor = darkColor.withAlphaComponent(0.4)

        setupView()
    }

    private func setupView() {
        
    }
}
