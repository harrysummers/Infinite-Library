//
//  GifCollectionViewCell.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/17/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    var gifView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.CustomColors.spotifyDark
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    private func setupView() {
        addSubview(gifView)
        gifView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gifView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gifView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        gifView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        gifView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gifView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
