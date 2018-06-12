//
//  File.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class GradientGenerator {
    func createLayer(in frame: CGRect, from firstColor: CGColor, to secondColor: CGColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [firstColor, secondColor]
        return gradientLayer
    }
}
