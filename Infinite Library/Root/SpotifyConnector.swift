//
//  SpotifyConnector.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SpotifyLogin

class SpotifyConnector {
    
    func connect() {
        let url = URL(string: Constants.APP_URL)
        SpotifyLogin.shared.configure(clientID: EnvConstants.CLIENT_ID, clientSecret: EnvConstants.CLIENT_SECRET, redirectURL: url!)
    }
}
