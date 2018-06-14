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
        createListenLaterGroup()
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .welcomeViewController)
    }
    @objc func nextPressed() {
        TutorialPresenter.shared.showNext(from: self)
    }
    func createListenLaterGroup() {
        let albumName = "Listen Later"
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            if !Group.nameAlreadyExists(albumName) {
                let group = Group(context: context)
                group.name = albumName
                CoreDataManager.shared.saveMainContext()
            }
        }
    }
}

extension WelcomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
