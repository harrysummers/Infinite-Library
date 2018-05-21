//
//  ArtistsTableViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/8/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreData

class ArtistsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    private let cellId = "artistId"
    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var fetchedResultsController: NSFetchedResultsController<Artist> = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        return frc
    }()
    
    
    // MARK: NSFetchResultsController Delegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
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
        MemoryCounter.shared.incrementCount(for: .artistsTableViewController)
        navigationController?.navigationBar.barTintColor = UIColor.CustomColors.spotifyExtraDark
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        tableView.separatorStyle = .none
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.keyboardDismissMode = .interactive
        tableView.sectionIndexColor = UIColor.CustomColors.offWhite
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(settingsPressed))
        title = "Artists"
        setupView()
    }
    
    deinit {
        MemoryCounter.shared.decrementCount(for: .artistsTableViewController)
    }
    
    @objc func settingsPressed() {
        let vc = SettingsViewController()
        present(vc, animated: true, completion: nil)
    }
    
    private func setupView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Albums"
        searchController.searchBar.barStyle = .black
        searchController.searchBar.keyboardAppearance = .dark
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let count = fetchedResultsController.sections?.count {
            return count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getArtistCount(for: section)
    }
    
    func getArtistCount(for section: Int) -> Int {
        if let sections = fetchedResultsController.sections, sections.count != 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = fetchedResultsController.object(at: indexPath)
        let cell = ArtistTableViewCell()
        if let stringUrl = artist.image_url, let url = URL(string: stringUrl) {
            cell.artistImage.af_setImage(withURL: url)
        }
        cell.nameLabel.text = artist.name ?? ""
        cell.backgroundColor = UIColor.CustomColors.spotifyDark
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artist = fetchedResultsController.object(at: indexPath)
        if let spotifyUrl = artist.external_url {
            let url = URL(string : spotifyUrl)
            UIApplication.shared.open(url!, options: [:], completionHandler: { (status) in })
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController.section(forSectionIndexTitle: title, at: index)
    }
}



