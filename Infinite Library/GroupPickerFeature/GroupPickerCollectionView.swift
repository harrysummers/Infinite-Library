//
//  GroupPickerCollectionView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class GroupPickerCollectionView: UIView {
    weak var viewController: GroupPickerCollectionViewController? {
        didSet {
            setupViewController()
        }
    }
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(GroupPickerCollectionCell.self, forCellWithReuseIdentifier: "groupPickerCell")
        collection.backgroundColor = UIColor.CustomColors.spotifyDark
        collection.bounces = true
        collection.alwaysBounceVertical = true
        collection.alwaysBounceHorizontal = false
        return collection
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    fileprivate func setupView() {
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    fileprivate func setupViewController() {
        if let view = viewController?.view {
            view.addSubview(self)
            leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

