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
    lazy var activityView: NVActivityIndicatorView = {
        var activityView =
            NVActivityIndicatorView(frame: CGRect.zero,
            type: .ballPulse,
            color: UIColor.CustomColors.offWhite,
            padding: nil)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .autoLoginViewController)
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        setupView()
        activityView.startAnimating()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityView.stopAnimating()
    }
    fileprivate func setupView() {
        view.addSubview(activityView)
        activityView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .autoLoginViewController)
    }
}
