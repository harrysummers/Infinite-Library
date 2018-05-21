//
//  WelcomeViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to Infinity Library"
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 3
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
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .welcomeViewController)
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        transitioningDelegate = self
        setupView()
    }
    
    deinit {
        MemoryCounter.shared.decrementCount(for: .welcomeViewController)
    }
    
    private func setupView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200.0).isActive = true

        
        view.addSubview(nextButton)
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25.0).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        
    }
    
    @objc func nextPressed() {
        TutorialPresenter.shared.showNext(from: self)
    }
    
}

extension WelcomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
