//
//  AlbumsTableViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import CoreData
import NYAlertViewController
import Whisper

class AlbumsTableViewController: UITableViewController,
    NSFetchedResultsControllerDelegate,
    GroupPickerDelegate {
    private let cellId = "albumId"
    private let searchController = UISearchController(searchResultsController: nil)
    let impact = UIImpactFeedbackGenerator()
    lazy var fetchedResultsController: NSFetchedResultsController<Album> = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "artist.name", ascending: true, selector:
                #selector(NSString.caseInsensitiveCompare(_:)))
        ]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: context,
                                             sectionNameKeyPath: "artist.name", cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        return frc
    }()
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .left)
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
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .left)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .albumsTableViewController)
        setupView()
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .albumsTableViewController)
    }
    fileprivate func setupView() {
        setupSearchController()
        setupTableView()
        setBackground()
        setTitle()
        setupNavigationItems()
    }
    fileprivate func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        searchController.searchBar.barStyle = .black
        searchController.searchBar.keyboardAppearance = .dark
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.keyboardDismissMode = .interactive
        tableView.sectionIndexColor = UIColor.CustomColors.offWhite
    }
    fileprivate func setBackground() {
        view.backgroundColor = UIColor.CustomColors.spotifyDark
    }
    fileprivate func setTitle() {
        title = "Albums"
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
        alertViewController.title = "Add Album"
        alertViewController.message = "Paste the spotify share link of the album you want to add."
        alertViewController.alertViewBackgroundColor = UIColor.CustomColors.spotifyLight
        alertViewController.messageColor = UIColor.CustomColors.offWhite
        alertViewController.titleColor = UIColor.CustomColors.offWhite
        alertViewController.swipeDismissalGestureEnabled = true
        alertViewController.backgroundTapDismissalGestureEnabled = true
        alertViewController.addTextField { (textField) in
            textField?.placeholder = "Paste Album Link Here"
            textField?.keyboardAppearance = .dark
        }
        let cancelAction = NYAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        weak var weakSelf = self
        let addAction = NYAlertAction(title: "Add", style: .default) { (_) in
            let textField = alertViewController.textFields[0] as? UITextField
            let text = textField?.text ?? ""
            guard let pasteAlbum = weakSelf?.getPasteAlbum(with: text) else { return }
            AlbumRetriever(with: pasteAlbum).retrieve { (_, downloader) in
                if let downloader = downloader {
                    weakSelf?.saveAlbum(downloader)
                } else {
                    DispatchQueue.main.async {
                        alertViewController.messageColor = .red
                        alertViewController.message =
                        "Either the url is not valid or the album is already in your library."
                    }
                }
                DispatchQueue.main.async {
                    weakSelf?.impact.impactOccurred()
                }
            }
        }
        alertViewController.addAction(cancelAction)
        alertViewController.addAction(addAction)

        present(alertViewController, animated: true, completion: nil)
    }
    fileprivate func getPasteAlbum(with url: String) -> PasteAlbum {
        return PasteAlbum(albumId: url.getAlbumId() ?? "",
                                    externalUrl: url.getAlbumExternalUrl() ?? "")
    }
    fileprivate func saveAlbum(_ albumDownloader: AlbumDownloader) {
        weak var weakSelf = self
        albumDownloader.saveToDatabase {
            albumDownloader.getArt()
            weakSelf?.dismiss(animated: true, completion: nil)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let count = fetchedResultsController.sections?.count {
            return count
        } else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAlbumCount(for: section)
    }
    func getAlbumCount(for section: Int) -> Int {
        if let sections = fetchedResultsController.sections, sections.count != 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = fetchedResultsController.object(at: indexPath)
        let cell = AlbumsTableViewCell()
        cell.nameLabel.text = album.name
        cell.artistLabel.text = album.artist?.name ?? ""
        if let imageUrl = album.image_url, let artUrl = URL(string: imageUrl) {
            cell.albumArt.af_setImage(withURL: artUrl)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = fetchedResultsController.object(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        if let spotifyUrl = album.external_url {
            let url = URL(string: spotifyUrl)
            UIApplication.shared.open(url!, options: [:],
                                      completionHandler: { (_) in })
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController.section(forSectionIndexTitle: title, at: index)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(self.fetchedResultsController.object(at: indexPath))
            CoreDataManager.shared.saveMainContext()
        }
    }
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
                            -> UISwipeActionsConfiguration? {
        weak var weakSelf = self
        let album = fetchedResultsController.object(at: indexPath)
        let addAction = UIContextualAction(style: .normal, title: "Add to Group") { (_, _, completionHandler) in
            let viewController = GroupPickerCollectionViewController()
            viewController.delegate = self
            viewController.albumTarget = album
            let navController = UINavigationController(rootViewController: viewController)
            weakSelf?.present(navController, animated: true, completion: nil)
            completionHandler(true)
        }
        addAction.backgroundColor = UIColor.CustomColors.spotifyGreen
        let swipeAction = UISwipeActionsConfiguration(actions: [addAction])
        return swipeAction
    }
    func didSelectGroup(_ group: Group, _ album: Album) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            group.addToAlbums(album)
            CoreDataManager.shared.saveMainContext()
            DispatchQueue.main.async {
                let impact = UIImpactFeedbackGenerator()
                impact.impactOccurred()
                let murmur = Murmur(title: "Successfully Added",
                                    backgroundColor: UIColor.CustomColors.spotifyGreen,
                                    titleColor: .white,
                                    font: UIFont.systemFont(ofSize: 14),
                                    action: nil)
                Whisper.show(whistle: murmur)
            }
        }
    }
}
