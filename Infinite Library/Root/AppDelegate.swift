//
//  AppDelegate.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import CoreData
import SpotifyLogin
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Crashlytics.self])
        SpotifyConnector().connect()
        window = UIWindow.setup()
        GeneralAppearance().setup()
        window?.rootViewController = AutoLoginViewController()
        return true
    }
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        return SpotifyLogin.shared.applicationOpenURL(url) { (_) in }
    }
    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AsyncWebService.shared.getAccessToken { (_, _) in
            print("refreshed token")
        }
        Clipboard(with: window!).checkForAlbum()
    }
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveMainContext()
    }
}
