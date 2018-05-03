//
//  AsyncWebService.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation


final class AsyncWebService {
    
    static let shared = AsyncWebService()
    let token = "Bearer BQBhhOF4moy0mGSIG7P3wMDiBjPevlESTwCLJLAkqUPrkPcLZbRvbXtTb1ZA1ju6BQIGwe1-4228AjwfDjBhAQ46RYfQQr9zrTbTaYEuOaQ8MkQHNMmFkS2nJIpFlnMrpEiOM4WmJJ7kpNs"
    
    func sendAsyncRequest(request: URLRequest, onComplete:@escaping (_ status: Int, _ result: Data) -> Void) {
        var request = request
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            guard error == nil else {
                print("error on processing url request")
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            if (statusCode == 200) {
                onComplete(statusCode, responseData)
            } else {
                print("\(statusCode) ...")
                onComplete(statusCode, responseData)
            }
            
            
        }.resume()
    }
    
    func embedAuthorization() {
        
    }
    
    
}
