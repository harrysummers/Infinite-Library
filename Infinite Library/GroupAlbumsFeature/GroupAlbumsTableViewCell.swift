//
//  GroupAlbumsTableViewCell.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

import UIKit

class GroupAlbumsTableViewCell: UITableViewCell {
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(16.0)
        return label
    }()
    var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(13.0)
        label.textColor = UIColor.CustomColors.offWhite
        return label
    }()
    var albumArt: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor.CustomColors.spotifyExtraDark
        return image
    }()
    var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    fileprivate func setupView() {
        setupBackground()
        setupAlbumArt()
        setupVerticalStackView()
    }
    fileprivate func setupBackground() {
        backgroundColor = UIColor.CustomColors.spotifyDark
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = UIColor.CustomColors.spotifyExtraDark
        selectedBackgroundView = selectedBackground
    }
    fileprivate func setupAlbumArt() {
        addSubview(albumArt)
        albumArt.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        albumArt.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        albumArt.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        albumArt.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    fileprivate func setupVerticalStackView() {
        addSubview(verticalStackView)
        verticalStackView.heightAnchor.constraint(equalTo: albumArt.heightAnchor, constant: -10.0).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: albumArt.rightAnchor, constant: 10.0).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10.0).isActive = true
        verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(artistLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
