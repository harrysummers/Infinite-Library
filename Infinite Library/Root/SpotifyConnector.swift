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
        let url = URL(string: Constants.appUrl)
        SpotifyLogin.shared.configure(clientID: EnvConstants.clientId,
                                      clientSecret: EnvConstants.clientSecret,
                                      redirectURL: url!)
    }
}
