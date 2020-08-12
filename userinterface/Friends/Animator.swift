//
//  Animator.swift
//  userinterface
//
//  Created by Дарья Шимко on 03.08.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let distination = transitionContext.viewController(forKey: .to) else { return }
        
        
        transitionContext.containerView.addSubview(distination.view)
        distination.view.frame = source.view.frame
        distination.view.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                let transform = CGAffineTransform(translationX: -200, y: 0)
                let scaleTansform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                
                source.view.transform = transform.concatenating(scaleTansform)
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                let angleTranslation = CGAffineTransform(rotationAngle: (.pi / 2))
                
                distination.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(angleTranslation)
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                
                distination.view.transform = .identity
                
                
            }
            
            
        }) { (result) in
            
            if result && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
                transitionContext.completeTransition(true)
            }
            else {
                transitionContext.completeTransition(false)
            }
        }
        
    }
    
}

class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let distination = transitionContext.viewController(forKey: .to) else { return }
        
        
        transitionContext.containerView.addSubview(distination.view)
        transitionContext.containerView.sendSubviewToBack(distination.view)
        
        distination.view.frame = source.view.frame
        
        let translation = CGAffineTransform(translationX: -200, y: 0)
        distination.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(translation)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                
                let angleTranslation = CGAffineTransform(rotationAngle: -(.pi / 2))
                
                source.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).concatenating(angleTranslation)
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4) {
                
                source.view.transform = CGAffineTransform(rotationAngle: (.pi / 2))
                
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                
                distination.view.transform = .identity
                
            }
            
        }) { (result) in
            
            if result && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
                transitionContext.completeTransition(true)
            }
            else if transitionContext.transitionWasCancelled {
                distination.view.transform = .identity
                transitionContext.completeTransition(false)
            }
        }
        
    }
}

