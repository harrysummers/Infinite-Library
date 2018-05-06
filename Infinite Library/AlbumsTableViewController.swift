//
//  AlbumsTableViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import AlamofireImage

class AlbumsTableViewController: UITableViewController {

    private var albums = [LibraryAlbum]()
    private let cellId = "albumId"
    private var activityView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.CustomColors.spotifyExtraDark
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        tableView.separatorStyle = .none
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: cellId)
        title = "Albums"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadTapped))

    }
    
    @objc func downloadTapped() {
        startActivityIndicator()
        LibraryDownloader().download { (library) in
            if let items = library.items {
                self.albums = items
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityView?.stopAnimating()
            }
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let libraryAlbum = albums[indexPath.row]
        let cell = AlbumsTableViewCell()
        cell.nameLabel.text = libraryAlbum.album?.name
        cell.artistLabel.text = libraryAlbum.album?.artists?[0].name ?? ""
        
        if let images = libraryAlbum.album?.images, images.count > 0 {
            let artString = images[0].url
            if let artUrl = URL(string: artString) {
                cell.albumArt.af_setImage(withURL: artUrl)
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let libraryAlbum = albums[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let spotifyUrl = libraryAlbum.album?.external_urls?.spotify {
            let url = URL(string : spotifyUrl)
            UIApplication.shared.open(url!, options: [:], completionHandler: { (status) in })
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }


}
