//
//  OnboardingViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class TutorialScreenViewController: UIViewController {
    let tutorialScreenView: TutorialScreenView = {
        let view = TutorialScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    fileprivate let transition = SlideLeftAnimator()
    var titleText = ""
    var gif = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .tutorialScreenViewController)
        tutorialScreenView.viewController = self
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        transitioningDelegate = self
        tutorialScreenView.titleLabel.text = titleText
        tutorialScreenView.gifView.loadGif(name: gif)
        tutorialScreenView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .tutorialScreenViewController)
    }
    @objc func nextPressed() {
        TutorialPresenter.shared.showNext(from: self)
    }
}

extension TutorialScreenViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
