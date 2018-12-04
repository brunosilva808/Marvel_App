//
//  PopAnimator.swift
//  iBanwallet
//
//  Created by Bruno Silva on 25/11/2018.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let detailsView = self.presenting ? toView : transitionContext.view(forKey: .from)!
        let initialFrame = self.presenting ? self.originFrame : detailsView.frame
        let finalFrame = self.presenting ? detailsView.frame : self.originFrame
        
        let xScaleFactor = self.presenting ?
            
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = self.presenting ?
            
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor,
                                               y: yScaleFactor)
        
        if self.presenting {
            detailsView.transform = scaleTransform
            detailsView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            detailsView.clipsToBounds = true
        }

        containerView.addSubview(toView)
        containerView.bringSubviewToFront(detailsView)
        
        UIView.animate(withDuration: duration,
                       delay:0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0,
                       animations: {
                       detailsView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                       detailsView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
                        transitionContext.completeTransition(true)
        })

    }

}
