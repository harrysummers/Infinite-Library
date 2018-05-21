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
    let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let transition = SlideLeftAnimator()
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .loginViewController)
        loginView.viewController = self
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        NotificationCenter.default.addObserver(self, selector:
            #selector(loginSuccessful), name: .SpotifyLoginSuccessful, object: nil)
        transitioningDelegate = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        MemoryCounter.shared.decrementCount(for: .loginViewController)
    }
    func goToLibraryDownloader() {
        let viewController = LibraryDownloadViewController()
        viewController.present(from: self)
    }
    func goToAlbums() {
        let viewController = TabViewController()
        viewController.present(from: self)
    }
    @objc func loginSuccessful() {
        weak var weakSelf = self
        AsyncWebService.shared.getAccessToken { (_, error) in
            if error == nil {
                weakSelf?.isEmptyLibrary { (isEmpty) in
                    if isEmpty {
                        weakSelf?.goToLibraryDownloader()
                    } else {
                        weakSelf?.goToAlbums()
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
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
