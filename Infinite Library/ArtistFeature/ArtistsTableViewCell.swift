//
//  ArtistsTableViewCell.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/8/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    var artistImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.CustomColors.spotifyExtraDark
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(16.0)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.CustomColors.spotifyDark
        
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = UIColor.CustomColors.spotifyExtraDark
        selectedBackgroundView = selectedBackground
    
        addSubview(artistImage)
        artistImage.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        artistImage.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        artistImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        artistImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        artistImage.layer.cornerRadius = 45.0 / 2
        artistImage.clipsToBounds = true
        
        addSubview(nameLabel)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: artistImage.rightAnchor, constant: 10.0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10.0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
