//
//  SettingsViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/16/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SpotifyLogin
import SwiftGifOrigin

class SettingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let settingsView: SettingsView = {
        let view = SettingsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellId = "gifCell"

    var gifs = ["addAlbum", "album", "artist"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .settingsViewController)
        setupSettingsView()
    }
    
    deinit {
        MemoryCounter.shared.decrementCount(for: .settingsViewController)
    }
    
    fileprivate func setupSettingsView() {
        settingsView.viewController = self
        settingsView.closeButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        settingsView.logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        settingsView.collectionView.delegate = self
        settingsView.collectionView.dataSource = self
    }
    
    @objc func closePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func logoutPressed() {
        logout()
        goToLoginScreen()
    }
    
    fileprivate func logout() {
        SpotifyLogin.shared.logout()
    }
    
    fileprivate func goToLoginScreen() {
        let vc = LoginViewController()
        vc.present(from: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gif = gifs[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GifCollectionViewCell
        cell.gifView.loadGif(name: gif)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

}
