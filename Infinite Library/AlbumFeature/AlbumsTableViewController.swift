//
//  AlbumsTableViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import AlamofireImage
import CoreData

class AlbumsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    private let cellId = "albumId"
    private var activityView: UIActivityIndicatorView?
    private let searchController = UISearchController(searchResultsController: nil)

    
    lazy var fetchedResultsController: NSFetchedResultsController<Album> = {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "artist.name", ascending: true)
        ]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "artist.name", cacheName: nil)
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
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        tableView.separatorStyle = .none
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.keyboardDismissMode = .interactive
        tableView.sectionIndexColor = UIColor.CustomColors.offWhite
        title = "Albums"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearTapped))
        
        setupView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.delegate = self
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
    
    @objc func downloadTapped() {
        startActivityIndicator()
        LibraryDownloader().download { (library) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityView?.stopAnimating()
            }
        }
    }
    
    @objc func clearTapped() {
        let fetch1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Artist")
        let request1 = NSBatchDeleteRequest(fetchRequest: fetch1)

        do {
            _ = try CoreDataManager.shared.persistentContainer.viewContext.execute(request1)
        } catch let err {
            print(err)
        }
        
        let fetch2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        let request2 = NSBatchDeleteRequest(fetchRequest: fetch2)
        do {
            _ = try CoreDataManager.shared.persistentContainer.viewContext.execute(request2)
        } catch let err {
            print(err)
        }
        
        do {
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch let err {
            print(err)
        }
    }
    
    private func startActivityIndicator() {
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        if let activityView = activityView {
            activityView.center = self.view.center
            activityView.startAnimating()
            self.view.addSubview(activityView)
        }
    }
    
    // MARK: - Table view data source

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
        return fetchedResultsController.sections![section].numberOfObjects
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
            let url = URL(string : spotifyUrl)
            UIApplication.shared.open(url!, options: [:], completionHandler: { (status) in })
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
    
}

extension AlbumsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        var predicate: NSPredicate?
        if searchText.count > 0 {
            predicate = NSPredicate(format: "(name contains[cd] %@) || (artist.name contains[cd] %@)", searchText, searchText)
        } else {
            predicate = nil
        }
        
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let err {
            print(err)
        }

    }
    
}

extension AlbumsTableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
}

