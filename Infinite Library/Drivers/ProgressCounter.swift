//
//  ProgressCounter.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/17/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class ProgressCounter {
    
    private(set) var count = 0
    private var label: UILabel?
    
    init(with progressLabel: UILabel) {
        label = progressLabel
    }
    
    init(with progressLabel: UILabel, and initialCount: Int) {
        label = progressLabel
        count = initialCount
    }
    
    func increment() {
        if count < 98 {
            count = count + 4
            label?.text = "\(count)%"
        }
    }
    
    func complete() {
        count = 100
        label?.text = "\(count)%"
    }
}
