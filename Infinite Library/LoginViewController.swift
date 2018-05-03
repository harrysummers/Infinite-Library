//
//  ViewController.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SpotifyLogin

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccessful), name: .SpotifyLoginSuccessful, object: nil)
        
        
        let button = SpotifyLoginButton(viewController: self, scopes: [.streaming, .userLibraryRead])
        self.view.addSubview(button)
        

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func enterApp() {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginSuccessful() {
        AsyncWebService.shared.getAccessToken { (_, error) in
            if error == nil {
                self.enterApp()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

