//
//  CircularRevealAnimator.swift
//  CircularRevealAnimator
//
//  Created by Kosuke Kito on 2015/06/23.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class CircularRevealAnimator : NSObject {
    private let center: CGPoint
    private let duration: NSTimeInterval
    private let isPresent: Bool
    private var completionHandler: (() -> Void)?
    
    init(center: CGPoint, duration: NSTimeInterval = 0.5, isPresent: Bool) {
        self.center = center
        self.duration = duration
        self.isPresent = isPresent
    }
    
    dynamic override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        completionHandler?()
    }
}

extension CircularRevealAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containerView = transitionContext.containerView(),
            source = transitionContext.viewForKey(UITransitionContextFromViewKey),
            target = transitionContext.viewForKey(UITransitionContextToViewKey) else {
                return
        }
        
        completionHandler = { _ in
            transitionContext.completeTransition(true)
        }
        
        let radius = { () -> CGFloat in
            let x = max(center.x, containerView.frame.width - center.x)
            let y = max(center.y, containerView.frame.height - center.y)
            return sqrt(x * x + y * y)
        }()
        
        let rectAroundCircle = { (radius: CGFloat) -> CGRect in
            return CGRectInset(CGRect(origin: self.center, size: CGSizeZero), -radius, -radius)
        }
        
        let zeroPath = CGPathCreateWithEllipseInRect(rectAroundCircle(0), nil)
        let fullPath = CGPathCreateWithEllipseInRect(rectAroundCircle(radius), nil)
        
        if isPresent {
            containerView.insertSubview(target, aboveSubview: source)
            addAnimation(target, fromValue: zeroPath, toValue: fullPath)
        } else {
            containerView.insertSubview(target, belowSubview: source)
            addAnimation(source, fromValue: fullPath, toValue: zeroPath)
        }
    }
}

extension CircularRevealAnimator {
    private func addAnimation(viewController: UIView, fromValue: CGPath, toValue: CGPath) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        viewController.layer.mask = CAShapeLayer()
        viewController.layer.mask?.addAnimation(animation, forKey: nil)
    }
}