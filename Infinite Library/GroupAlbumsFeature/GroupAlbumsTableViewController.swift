//
//  GroupAlbumsTableViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import CoreData
import NYAlertViewController

class GroupAlbumsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    private let cellId = "albumId"
    var group: Group?
    private let searchController = UISearchController(searchResultsController: nil)
    let impact = UIImpactFeedbackGenerator()
    lazy var fetchedResultsController: NSFetchedResultsController<Album> = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "artist.name", ascending: true)
        ]
        if let name = group?.name {
            request.predicate = NSPredicate(format: "group.name = %@", name)
        }
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
        title = group?.name ?? ""
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
        let cell = GroupAlbumsTableViewCell()
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
            weak var weakSelf = self
            context.perform {
                if let album = weakSelf?.fetchedResultsController.object(at: indexPath) {
                    weakSelf?.group?.removeFromAlbums(album)
                }
            }
        }
    }
}
