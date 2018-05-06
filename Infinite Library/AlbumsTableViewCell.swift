//
//  AlbumsTableViewCell.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/4/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    var albumArt: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.CustomColors.spotifyLight
        
        addSubview(albumArt)
        albumArt.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        albumArt.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        albumArt.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0).isActive = true
        albumArt.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameLabel)
        nameLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: albumArt.rightAnchor, constant: 10.0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        
        addSubview(artistLabel)
        artistLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        artistLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0).isActive = true
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
