//
//  AutoLoginViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AutoLoginViewController: UIViewController {
    var autoLoginView: AutoLoginView = {
        var view = AutoLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .autoLoginViewController)
        autoLoginView.viewController = self
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        autoLoginView.retryButton.isHidden = true
        autoLoginView.retryButton.addTarget(self, action: #selector(retryPressed), for: .touchUpInside)
        showInitialViewController()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        autoLoginView.activityView.stopAnimating()
    }

    @objc func retryPressed() {
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.autoLoginView.retryButton.isHidden = true
            weakSelf?.autoLoginView.activityView.startAnimating()
        }
        showInitialViewController()
    }
    func showInitialViewController() {
        autoLoginView.activityView.startAnimating()
        InitialViewControllerChooser().show { (viewController) in
            guard let viewController = viewController else { return }
            DispatchQueue.main.async {
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .autoLoginViewController)
    }
}
