//
//  LoginView.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/21/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import SpotifyLogin

class LoginView: UIView {
    weak var viewController: LoginViewController? {
        didSet {
            setupViewController()
        }
    }
    var spotifyButton: SpotifyLoginButton?
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign into your Spotify account"
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 3
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        guard let spotifyButton = spotifyButton else { return }
        addSubview(spotifyButton)
        spotifyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.0).isActive = true
        spotifyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    fileprivate func setupViewController() {
        guard let viewController = viewController else { return }

        spotifyButton = SpotifyLoginButton(viewController: viewController, scopes: [.streaming, .userLibraryRead])
        spotifyButton?.translatesAutoresizingMaskIntoConstraints = false

        if let view = viewController.view {
            view.addSubview(self)
            leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            setupView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
