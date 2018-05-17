//
//  TutorialScreen4.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/15/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class TutorialScreen4: UIViewController {
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "View this tutorial again in the settings"
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 4
        return label
    }()
    
    var nextButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        return button
    }()
    
    var gifView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.CustomColors.spotifyDark
        return imageView
    }()
    
    
    let transition = SlideLeftAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        transitioningDelegate = self
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        view.addSubview(gifView)
        gifView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        gifView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        gifView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        gifView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gifView.loadGif(name: "settings")
        
        view.addSubview(nextButton)
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25.0).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
    
    @objc func nextPressed() {
        let vc = LoginViewController()
        present(vc, animated: true, completion: nil)
    }
    
}

extension TutorialScreen4: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
