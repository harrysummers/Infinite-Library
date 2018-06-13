//
//  GroupPickerCollectionCell.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class GroupPickerCollectionCell: UICollectionViewCell {
    let artView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    fileprivate func setupView() {
        setupArtView()
        createGradientLayer()
        setupNameLabel()
    }
    func setupArtView() {
        addSubview(artView)
        artView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        artView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        artView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        artView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10.0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
    }
    func createGradientLayer() {
        let redColor = UIColor.hexStringToUIColor(hex: "#C33764").withAlphaComponent(0.8).cgColor
        let yellowColor = UIColor.hexStringToUIColor(hex: "##1D2671").withAlphaComponent(0.8).cgColor
        let gradientLayer = GradientGenerator().createLayer(in: bounds,
                                                            from: redColor,
                                                            to: yellowColor)
        layer.addSublayer(gradientLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

