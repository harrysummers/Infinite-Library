//
//  AsyncWebService.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import SpotifyLogin
import Whisper

final class AsyncWebService {
    static let shared = AsyncWebService()
    var token = ""
    func sendAsyncRequest(request: URLRequest, onComplete:@escaping (_ status: Int, _ result: Data) -> Void) {
        var request = request
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("error on processing url request")
                print(error!)
                DispatchQueue.main.async {
                    let murmur = Murmur(title: "Internet Connectivity Issue",
                                        backgroundColor: UIColor.CustomColors.spotifyDark,
                                        titleColor: UIColor.white,
                                        font: UIFont.systemFont(ofSize: 14), action: nil)
                    Whisper.show(whistle: murmur, action: .show(2.5))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            if statusCode == 200 {
                onComplete(statusCode, responseData)
            } else {
                print("\(statusCode) ...")
                onComplete(statusCode, responseData)
            }
        }.resume()
    }
    func getAccessToken(onComplete:@escaping(_ accessToken: String?, _ error: Error?) -> Void) {

        SpotifyLogin.shared.getAccessToken { (accessToken, error) in
            if let accessToken = accessToken {
                self.token = "Bearer " + accessToken
            }
            onComplete(accessToken, error)
        }
    }
}
