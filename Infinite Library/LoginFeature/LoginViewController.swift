//
//  ViewController.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SpotifyLogin

class LoginViewController: UIViewController {
    
    lazy var spotifyButton: SpotifyLoginButton = {
        var button = SpotifyLoginButton(viewController: self, scopes: [.streaming, .userLibraryRead])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let transition = SlideLeftAnimator()
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign into your Spotify account"
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 3
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessful), name: .SpotifyLoginSuccessful, object: nil)
        setupView()
        transitioningDelegate = self
    }
    
    private func setupView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        view.addSubview(spotifyButton)
        spotifyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25.0).isActive = true
        spotifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func goToLibraryDownloader() {
        let vc = LibraryDownloadViewController()
        present(vc, animated: true, completion: nil)
    }
    
    func goToAlbums() {
        let vc = TabViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func loginSuccessful() {
        AsyncWebService.shared.getAccessToken { (_, error) in
            if error == nil {
                self.isEmptyLibrary { (isEmpty) in
                    if isEmpty {
                        self.goToLibraryDownloader()
                    } else {
                        self.goToAlbums()
                    }
                }
            }
        }
    }
    
    private func isEmptyLibrary(_ onComplete:@escaping (_ isEmpty: Bool) -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            let count = Album.getAlbumCount(in: context)
            onComplete(count < 1)
        }
    }
}

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}



