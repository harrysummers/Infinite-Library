//
//  AutoLoginViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class AutoLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MemoryCounter.shared.incrementCount(for: .autoLoginViewController)
        view.backgroundColor = UIColor.CustomColors.spotifyDark
    }
    deinit {
        MemoryCounter.shared.decrementCount(for: .autoLoginViewController)
    }
}
