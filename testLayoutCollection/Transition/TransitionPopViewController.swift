//
//  TransitionDismissViewController.swift
//  testTransition3
//
//  Created by oneweek on 2/24/17.
//  Copyright © 2017 Harry Nguyen. All rights reserved.
//

import UIKit

class TransitionPopViewController: NSObject, UIViewControllerAnimatedTransitioning {
    var destinationFrame = CGRect(x: screenSize.width/2, y: screenSize.height/2, width: 0, height: 0)
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else{
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
//        toVC.view.alpha = 0
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let snap = UIImageView(frame: screenSize)
        snap.contentMode = .scaleAspectFill
        snap.clipsToBounds = true
        snap.image = TransitionManager.shared.photo
        containerView.addSubview(snap)
        fromVC.view.alpha = 0

        
        if transitionContext.transitionWasCancelled {
            print("transitionWasCancelled")
        }else{
            print("Transitin success")
        }
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            snap.frame = self.destinationFrame
        }) { (finish) in
            if transitionContext.transitionWasCancelled {
                fromVC.view.alpha = 1
            }else{
                fromVC.view.removeFromSuperview()
            }
            snap.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
