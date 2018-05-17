//
//  LibraryDownloadViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LibraryDownloadViewController: UIViewController {
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Download your existing library"
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        label.textColor = UIColor.CustomColors.offWhite
        label.numberOfLines = 3
        return label
    }()
    
    var downloadButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyGreen
        button.tintColor = .white
        return button
    }()
    
    var skipButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.CustomColors.spotifyLight
        button.tintColor = .white
        return button
    }()
    
    var buttonStack: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15.0
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.contentMode = .center
        return stackView
    }()
    
    lazy var activityView: NVActivityIndicatorView = {
        var activityView = NVActivityIndicatorView(frame: self.view.frame, type: .ballPulse, color: UIColor.CustomColors.offWhite, padding: nil)
        activityView.center = self.view.center
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    var progressLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColors.offWhite
        label.isHidden = true
        return label
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
        
        view.addSubview(activityView)
        activityView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        activityView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(buttonStack)
        buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15.0).isActive = true
        buttonStack.widthAnchor.constraint(equalToConstant: 200).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: 115).isActive = true
        buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        buttonStack.addArrangedSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipPressed), for: .touchUpInside)
        
        buttonStack.addArrangedSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(downloadPressed), for: .touchUpInside)

        view.addSubview(progressLabel)
        progressLabel.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -15.0).isActive = true
        progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    @objc func downloadPressed() {
        startProgressViews()
        let libraryDownloader = LibraryDownloader()
        libraryDownloader.progressCounter = ProgressCounter(with: progressLabel)
        libraryDownloader.download { (library) in
            DispatchQueue.main.async {
                self.stopProgressViews()
                let vc = TabViewController()
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @objc func skipPressed() {
        let vc = TabViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    private func startProgressViews() {
        activityView.startAnimating()
        progressLabel.isHidden = false
        progressLabel.text = "0%"
    }
    
    private func stopProgressViews() {
        self.activityView.stopAnimating()
        progressLabel.isHidden = true
        
    }
    
}

extension LibraryDownloadViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
