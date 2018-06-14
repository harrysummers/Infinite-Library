//
//  GroupsCollectionViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage
import NYAlertViewController

class GroupsCollectionViewController: UIViewController,
        UICollectionViewDataSource, UICollectionViewDelegate,
        UICollectionViewDelegateFlowLayout,
        UIGestureRecognizerDelegate,
        NSFetchedResultsControllerDelegate {
    let groupsCollectionView: GroupsCollectionView = {
        let view = GroupsCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let estimateWidth = 160.0
    let cellMarginSize = 24.0
    lazy var fetchedResultsController: NSFetchedResultsController<Group> = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Group> = Group.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        return frc
    }()
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        groupsCollectionView.collectionView.performBatchUpdates(nil, completion: nil)
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            groupsCollectionView.collectionView.insertSections(IndexSet(integer: sectionIndex))
        case .delete:
            groupsCollectionView.collectionView.deleteSections(IndexSet(integer: sectionIndex))
        case .move:
            break
        case .update:
            break
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            groupsCollectionView.collectionView.insertItems(at: [newIndexPath!])
        case .delete:
            groupsCollectionView.collectionView.deleteItems(at: [indexPath!])
        case .update:
            groupsCollectionView.collectionView.reloadItems(at: [indexPath!])
        case .move:
            groupsCollectionView.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getGroupCount(for: section)
    }
    func getGroupCount(for section: Int) -> Int {
        if let sections = fetchedResultsController.sections, sections.count != 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let count = fetchedResultsController.sections?.count {
            return count
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "groupCell",
            for: indexPath) as? GroupCollectionCell else { return GroupCollectionCell() }
        let group = fetchedResultsController.object(at: indexPath)
        cell.nameLabel.text = group.name
        guard let url = AlbumArtChooser(with: group).getAlbumArtUrl() else { return cell }
        cell.artView.af_setImage(withURL: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        groupsCollectionView.collectionView.deselectItem(at: indexPath, animated: true)
        let group = fetchedResultsController.object(at: indexPath)
        let viewController = GroupAlbumsTableViewController()
        viewController.group = group
        navigationController?.pushViewController(viewController, animated: true)
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
            showActionSheet(for: index)
            print(index.row)
        } else {
            print("Could not find index path")
        }
    }
    fileprivate func showActionSheet(for index: IndexPath) {
        let group = fetchedResultsController.object(at: index)
        let alertController = UIAlertController(title: group.name, message: "", preferredStyle: .actionSheet)
        weak var weakSelf = self
        let editNameButton = UIAlertAction(title: "Change Name", style: .default) { (_) in
            weakSelf?.edit(at: index)
        }
        let deleteButton = UIAlertAction(title: "Delete Group", style: .destructive) { (_) in
            weakSelf?.delete(at: index)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(editNameButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    fileprivate func delete(at index: IndexPath) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        weak var weakSelf = self
        context.perform {
            if let group = weakSelf?.fetchedResultsController.object(at: index) {
                context.delete(group)
                CoreDataManager.shared.saveMainContext()
            }
        }
    }
    fileprivate func changeName(at index: IndexPath, with newName: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        weak var weakSelf = self
        context.perform {
            if let group = weakSelf?.fetchedResultsController.object(at: index) {
                group.name = newName
                CoreDataManager.shared.saveMainContext()
            }
        }
    }
    fileprivate func edit(at index: IndexPath) {
        let group = fetchedResultsController.object(at: index)
        let alertViewController = NYAlertViewController()
        alertViewController.title = "Change Name"
        alertViewController.alertViewBackgroundColor = UIColor.CustomColors.spotifyLight
        alertViewController.messageColor = UIColor.CustomColors.offWhite
        alertViewController.titleColor = UIColor.CustomColors.offWhite
        alertViewController.swipeDismissalGestureEnabled = true
        alertViewController.backgroundTapDismissalGestureEnabled = true
        alertViewController.addTextField { (textField) in
            textField?.placeholder = "Group Name"
            textField?.keyboardAppearance = .dark
            textField?.text = group.name
        }
        weak var weakSelf = self
        let cancelAction = NYAlertAction(title: "Cancel", style: .cancel) { (_) in
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        let addAction = NYAlertAction(title: "Save", style: .default) { (_) in
            let textField = alertViewController.textFields[0] as? UITextField
            let text = textField?.text ?? ""
            if !Group.nameAlreadyExists(text) {
                weakSelf?.changeName(at: index, with: text)
                weakSelf?.dismiss(animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    alertViewController.messageColor = .red
                    alertViewController.message = "Group name already exists."
                }
            }
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(addAction)
        present(alertViewController, animated: true, completion: nil)
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
        weak var weakSelf = self
        let cancelAction = NYAlertAction(title: "Cancel", style: .cancel) { (_) in
            weakSelf?.dismiss(animated: true, completion: nil)
        }
        let addAction = NYAlertAction(title: "Add", style: .default) { (_) in
            let textField = alertViewController.textFields[0] as? UITextField
            let text = textField?.text ?? ""
            if !Group.nameAlreadyExists(text) {
                let context = CoreDataManager.shared.persistentContainer.viewContext
                let group = Group(context: context)
                group.name = text
                context.perform {
                    CoreDataManager.shared.saveMainContext()
                }
                weakSelf?.dismiss(animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    alertViewController.messageColor = .red
                    alertViewController.message = "Group name already exists."
                }
            }

        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(addAction)
        present(alertViewController, animated: true, completion: nil)
    }

    func setupGridview() {
        guard let flow = groupsCollectionView.collectionView.collectionViewLayout
             as? UICollectionViewFlowLayout else { return }
        flow.minimumInteritemSpacing = CGFloat(cellMarginSize)
        flow.minimumLineSpacing = CGFloat(cellMarginSize)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        return CGSize(width: width, height: width)
    }
    fileprivate func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        return width
    }
}
