//
//  NavigationBar+Appearance.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class GeneralAppearance {
    func setup() {
        UINavigationBar.setup()
        UITabBar.setup()

    }
}

extension UINavigationBar {
    static func setup() {
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = UIColor.CustomColors.spotifyExtraDark
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
}

extension UIWindow {
    static func setup() -> UIWindow {
        let window = UIWindow()
        window.backgroundColor = UIColor.CustomColors.spotifyDark
        window.makeKeyAndVisible()
        return window
    }
}

extension UITabBar {
    static func setup() {
        UITabBar.appearance().barTintColor = UIColor.CustomColors.spotifyExtraDark
        UITabBar.appearance().tintColor = UIColor.CustomColors.offWhite
    }
}
