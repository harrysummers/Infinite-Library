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
import AlamofireImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let url = URL(string: Constants.APP_URL)
        SpotifyLogin.shared.configure(clientID: EnvConstants.CLIENT_ID, clientSecret: EnvConstants.CLIENT_SECRET, redirectURL: url!)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().barTintColor = UIColor.CustomColors.spotifyExtraDark
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]

        //UIVisualEffectView.appearance(whenContainedInInstancesOf: [UIAlertController.classForCoder() as! UIAppearanceContainer.Type]).effect = UIBlurEffect(style: .dark)

        UITabBar.appearance().barTintColor = UIColor.CustomColors.spotifyExtraDark
        UITabBar.appearance().tintColor = UIColor.CustomColors.offWhite
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        var initialViewController: UIViewController?
        
        let vc = UIViewController()
        vc.view.backgroundColor = .purple
        window?.rootViewController = vc
        
        AsyncWebService.shared.getAccessToken { (accessToken, error) in
            if error == nil && accessToken != nil {
                initialViewController = TabViewController()
            } else {
                initialViewController = LoginViewController()
            }
            
            vc.present(initialViewController!, animated: true, completion: nil)
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = SpotifyLogin.shared.applicationOpenURL(url) { (error) in }
        return handled
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if let clipboard = UIPasteboard.general.string, let idString = clipboard.getAlbumId() {
            let albumDownloader = AlbumDownloader()
            albumDownloader.download(idString) { (album) in
                DispatchQueue.main.async {
                    self.showActionSheet(with: album, and: albumDownloader)
                }
            }
            
        }
        
    }
    
    private func showActionSheet(with album: JSONAlbum, and albumDownloader: AlbumDownloader) {
        let imageView = UIImageView(frame: CGRect(x: 220, y: 5, width: 40, height: 40))
        
        if let images = album.images, images.count > 0, let url = URL(string: images[0].url) {
            imageView.af_setImage(withURL: url)
        }
        let title = "\(album.name ?? "") by \(album.artists?[0].name ?? "")"
        let alertView = UIAlertController(title: "Add Album", message: "\(title)", preferredStyle: .actionSheet)
        alertView.view.addSubview(imageView)
        alertView.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            albumDownloader.saveToDatabase()
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.window?.rootViewController?.presentedViewController?.present(alertView, animated: true, completion: nil)
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.shared.saveMainContext()
    }

    

}

