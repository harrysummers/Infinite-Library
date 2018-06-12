//
//  GroupsCollectionViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import AlamofireImage

class GroupsCollectionViewController: UIViewController,
        UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let groupsCollectionView: GroupsCollectionView = {
        let view = GroupsCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let estimateWidth = 160.0
    let cellMarginSize = 24.0
    let images = [
        "https://i.scdn.co/image/7d4761ee372386c43bd1e4ea225f0ccfc412f18b",
        "https://i.scdn.co/image/e67c37be368b0b47319f5c7a57ab5f4e3c262f3c",
        "https://i.scdn.co/image/7de30f477ba56e0dd40128fd2f8f91bd4bdd8c46"
    ]
    let titles = [
        "GOAT",
        "Favorites",
        "Best of Kanye"
    ]
    let colors = [
        GradientColor(fromColor: <#T##String#>, toColor: <#T##String#>)
    ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "groupCell",
            for: indexPath) as? GroupCollectionCell else { return GroupCollectionCell() }
        let url = URL(string: images[indexPath.row])!
        cell.artView.af_setImage(withURL: url)
        cell.nameLabel.text = titles[indexPath.row]
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsCollectionView.viewController = self
        groupsCollectionView.collectionView.delegate = self
        groupsCollectionView.collectionView.dataSource = self
        title = "Groups"
        setupGridview()
    }
    func setupGridview() {
        guard let flow = groupsCollectionView.collectionView.collectionViewLayout
             as? UICollectionViewFlowLayout else { return }
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        return CGSize(width: width, height: width)
    }
    fileprivate func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(self.estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(self.cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
}

struct GradientColor {
    var fromColor: String
    var toColor: String
    
    func getFromColor() -> CGColor {
        return UIColor.hexStringToUIColor(hex: fromColor).cgColor
    }
    func getToColor() -> CGColor {
        return UIColor.hexStringToUIColor(hex: toColor).cgColor
    }
}
