//
//  AlbumsTableViewController+Search.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//
import UIKit

extension AlbumsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        fetchedResultsController.fetchRequest.predicate = getPredicate(for: searchText)
        reloadFetchedResultsController()
    }
    fileprivate func getPredicate(for searchText: String) -> NSPredicate? {
        if searchText.count > 0 {
            return NSPredicate(format: "(name contains[cd] %@) || (artist.name contains[cd] %@)",
                searchText,
                searchText)
        } else {
            return nil
        }
    }
    fileprivate func reloadFetchedResultsController() {
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch let err {
            print(err)
        }
    }
}
