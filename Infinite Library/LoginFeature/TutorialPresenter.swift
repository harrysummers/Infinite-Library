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
        TutorialScreen(gif: "album", title: "Click on albums to play them on Spotify"),
        TutorialScreen(gif: "artist", title: "Click on artists to visit their artist page"),
        TutorialScreen(gif: "addAlbum", title: "Add new albums by copying the share link to the clipboard"),
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
