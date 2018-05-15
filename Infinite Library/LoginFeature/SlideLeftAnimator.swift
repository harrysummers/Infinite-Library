//
//  SlideLeftAnimator.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/14/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class SlideLeftAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 1.0
    private var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        let slideTransform = CGAffineTransform(translationX: toView.frame.width, y: 0)
        toView.transform = slideTransform
        
        let finalFrame = CGRect(x: -fromView.frame.width, y: 0, width: fromView.frame.width, height: fromView.frame.height)
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: toView)
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
                       animations: {
                        toView.transform = .identity
                        fromView.frame = finalFrame
                        
            },
                       completion: { _ in
                        transitionContext.completeTransition(true)
            }
        )
    }
    
    
}
