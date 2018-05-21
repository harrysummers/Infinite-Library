//
//  WelcomeViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    let welcomeView: WelcomeView = {
        let view = WelcomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let transition = PopAnimator()
    override func viewDidLoad() {
        super.viewDidLoad()
    MemoryCounter.shared.incrementCount(for: .welcomeViewController)
        welcomeView.viewController = self
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        transitioningDelegate = self
        welcomeView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)

    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .welcomeViewController)
    }
    @objc func nextPressed() {
        TutorialPresenter.shared.showNext(from: self)
    }
}

extension WelcomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
