//
//  OnboardingViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var nextButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        return button
    }()
    
    let transition = SlideLeftAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.CustomColors.spotifyDark
        transitioningDelegate = self
        
        setupView()
    }
    
    private func setupView() {
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

extension OnboardingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
