//
//  SystemPreferencesHelper.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/23/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    let defaults = UserDefaults()
    private let isLoggedIn = "isLoggedIn"
    func login() {
        UserDefaultsHelper.shared.defaults.set(true, forKey: isLoggedIn)
    }
    func logout() {
        UserDefaultsHelper.shared.defaults.set(false, forKey: isLoggedIn)
    }
    func getLoggedIn() -> Bool {
        let isLoggedInValue = UserDefaultsHelper.shared.defaults.bool(forKey: isLoggedIn)
        return isLoggedInValue
    }
    func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
