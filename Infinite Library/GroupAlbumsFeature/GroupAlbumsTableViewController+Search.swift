//
//  GroupsAlbumsTableViewController+Search.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

//"(group.name = %@) AND ((name contains[cd] %@) OR (artist.name contains[cd] %@))"

import UIKit

extension GroupAlbumsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        fetchedResultsController.fetchRequest.predicate = getPredicate(for: searchText)
        reloadFetchedResultsController()
    }
    fileprivate func getPredicate(for searchText: String) -> NSPredicate? {
        guard let name = group?.name else { return nil }
        if searchText.count > 0 {
            return NSPredicate(
                format: "(group.name = %@) AND ((name contains[cd] %@) OR (artist.name contains[cd] %@))",
                name, searchText, searchText)
        } else {
            return NSPredicate(format: "group.name == %@", name)
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
