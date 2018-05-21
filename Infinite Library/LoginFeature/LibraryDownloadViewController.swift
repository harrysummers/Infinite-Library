//
//  LibraryDownloadViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CoreData

class LibraryDownloadViewController: UIViewController {

    let libraryDownloaderView: LibraryDownloaderView = {
        let view = LibraryDownloaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let transition = SlideLeftAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .libraryDownloadViewController)
        libraryDownloaderView.viewController = self
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        transitioningDelegate = self
                libraryDownloaderView.skipButton.addTarget(self, action: #selector(skipPressed), for: .touchUpInside)
                libraryDownloaderView.downloadButton.addTarget(self,
                                                               action: #selector(downloadPressed), for: .touchUpInside)
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .libraryDownloadViewController)
    }
    @objc func downloadPressed() {
        startProgressViews()
        let libraryDownloader = LibraryDownloader()
        libraryDownloader.progressCounter = ProgressCounter(with: libraryDownloaderView.progressLabel)
        weak var weakSelf = self
        libraryDownloader.download { (_) in
            DispatchQueue.main.async {
                weakSelf?.stopProgressViews()
                let viewController = TabViewController()
                guard let weakSelf = weakSelf else { return }
                viewController.present(from: weakSelf)
            }
        }
    }
    @objc func skipPressed() {
        let viewController = TabViewController()
        viewController.present(from: self)
    }
    private func startProgressViews() {
        libraryDownloaderView.activityView.startAnimating()
        libraryDownloaderView.progressLabel.isHidden = false
        libraryDownloaderView.progressLabel.text = "0%"
    }
    private func stopProgressViews() {
        libraryDownloaderView.activityView.stopAnimating()
        libraryDownloaderView.progressLabel.isHidden = true
    }
}

extension LibraryDownloadViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
