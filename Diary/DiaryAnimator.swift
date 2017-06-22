//
//  DiaryAnimator.swift
//  Diary
//
//  Created by 夏语诚 on 2017/6/22.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class DiaryAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation!
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let fromView = fromVC?.view
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let toView = toVC?.view
        toView?.alpha = 0.0
        
        if operation == UINavigationControllerOperation.pop {
            toView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } else {
            toView?.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }
        
        containerView.insertSubview(toView!, aboveSubview: fromView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            if self.operation == UINavigationControllerOperation.pop {
                fromView?.transform = CGAffineTransform(scaleX: 3.3, y: 3.3)
            } else {
                toView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
            toView?.alpha = 1.0
        }) { finished in
            transitionContext.completeTransition(true)
        }
    }
}
