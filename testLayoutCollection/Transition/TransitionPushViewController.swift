//
//  TransitionPresentViewController.swift
//  testTransition3
//
//  Created by oneweek on 2/23/17.
//  Copyright © 2017 Harry Nguyen. All rights reserved.
//

import UIKit
let screenSize = UIScreen.main.bounds

class TransitionPushViewController: NSObject, UIViewControllerAnimatedTransitioning {
    var originFrame = CGRect(x: screenSize.width/2, y: screenSize.height/2, width: 0, height: 0)
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
//        let fromVC = transitionContext.viewController(forKey: .from)
        guard let toVC = transitionContext.viewController(forKey: .to) else{
            return
        }
        let containerView = transitionContext.containerView
        toVC.view.alpha = 0
        containerView.addSubview(toVC.view)
//        toVC.view.frame = originFrame
        
//        let snap = toVC.view.snapshotView(afterScreenUpdates: true)
//        snap?.frame = originFrame
        let snap = UIImageView(frame: originFrame)
        snap.contentMode = .scaleAspectFill
        snap.clipsToBounds = true
        snap.image = TransitionManager.shared.photo
        
        containerView.addSubview(snap)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            snap.frame = screenSize
        }) { (finish) in
            toVC.view.alpha = 1
            snap.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
