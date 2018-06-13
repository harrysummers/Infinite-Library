//
//  GroupsCollectionViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import AlamofireImage
import NYAlertViewController

class GroupsCollectionViewController: UIViewController,
        UICollectionViewDataSource, UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout,
        UIGestureRecognizerDelegate {
    let groupsCollectionView: GroupsCollectionView = {
        let view = GroupsCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let estimateWidth = 160.0
    let cellMarginSize = 24.0
    let images = [
        "https://google.com",
        "https://i.scdn.co/image/e67c37be368b0b47319f5c7a57ab5f4e3c262f3c",
        "https://i.scdn.co/image/7de30f477ba56e0dd40128fd2f8f91bd4bdd8c46"
    ]
    let titles = [
        "GOAT",
        "Favorites",
        "Best of Kanye this is a really long name lol"
    ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "groupCell",
            for: indexPath) as? GroupCollectionCell else { return GroupCollectionCell() }
        cell.nameLabel.text = titles[indexPath.row]
        let url = URL(string: images[indexPath.row])!
        cell.artView.af_setImage(withURL: url)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsCollectionView.viewController = self
        groupsCollectionView.collectionView.delegate = self
        groupsCollectionView.collectionView.dataSource = self
        title = "Groups"
        setupGridview()
        setupNavigationItems()
        addLongPressListener()
    }
    fileprivate func addLongPressListener() {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        groupsCollectionView.collectionView.addGestureRecognizer(lpgr)
    }
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        let location = gestureReconizer.location(in: groupsCollectionView.collectionView)
        let indexPath = groupsCollectionView.collectionView.indexPathForItem(at: location)
        if let index = indexPath {
            showActionSheet(for: index.row)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    fileprivate func showActionSheet(for index: Int) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let editNameButton = UIAlertAction(title: "Change Name", style: .default) { (action) in
            
        }
        let deleteButton = UIAlertAction(title: "Delete Group", style: .destructive) { (action) in
            
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(editNameButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    fileprivate func setupNavigationItems() {
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsPressed))
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
    }
    @objc func settingsPressed() {
        let viewController = SettingsViewController()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    @objc func addPressed() {
        let alertViewController = NYAlertViewController()
        alertViewController.title = "Add Group"
        alertViewController.message = "Organize your albums into groups. Type in the name of the group."
        alertViewController.alertViewBackgroundColor = UIColor.CustomColors.spotifyLight
        alertViewController.messageColor = UIColor.CustomColors.offWhite
        alertViewController.titleColor = UIColor.CustomColors.offWhite
        alertViewController.swipeDismissalGestureEnabled = true
        alertViewController.backgroundTapDismissalGestureEnabled = true
        alertViewController.addTextField { (textField) in
            textField?.placeholder = "Group Name"
            textField?.keyboardAppearance = .dark
        }
        let cancelAction = NYAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        //weak var weakSelf = self
        let addAction = NYAlertAction(title: "Add", style: .default) { (_) in
            print(123)
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(addAction)
        present(alertViewController, animated: true, completion: nil)
    }
    func setupGridview() {
        guard let flow = groupsCollectionView.collectionView.collectionViewLayout
             as? UICollectionViewFlowLayout else { return }
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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
