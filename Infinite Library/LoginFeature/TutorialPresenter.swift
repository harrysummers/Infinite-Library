//
//  TutorialPresenter.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/20/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

struct TutorialScreen {
    var gif = ""
    var title = ""
}

class TutorialPresenter {
    private var tutorialIndex = 0
    static var shared = TutorialPresenter()
    fileprivate let tutorials: [TutorialScreen] = [
        TutorialScreen(gif: "artistsAndAlbums", title: "Click on albums or artists to open them on Spotify"),
        TutorialScreen(gif: "addAlbum", title: "Add new albums by copying the share link to the clipboard"),
        TutorialScreen(gif: "addGroup", title: "Organize your albums by creating groups"),
        TutorialScreen(gif: "settings", title: "View this tutorial again in the settings")
    ]

    func showNext(from viewController: UIViewController) {
        if !isLastViewController() {
            let tutorialScreen = tutorials[tutorialIndex]
            tutorialIndex += 1
            let toViewController = TutorialScreenViewController()
            toViewController.gif = tutorialScreen.gif
            toViewController.titleText = tutorialScreen.title
            toViewController.present(from: viewController)
        } else {
            let loginScreen = LoginViewController()
            loginScreen.present(from: viewController)
        }
    }
    fileprivate func isLastViewController() -> Bool {
        return tutorialIndex == tutorials.count
    }
}
