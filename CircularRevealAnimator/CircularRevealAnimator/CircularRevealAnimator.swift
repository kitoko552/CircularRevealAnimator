//
//  CircularRevealAnimator.swift
//  CircularRevealAnimator
//
//  Created by 木藤 紘介 on 2015/06/23.
//  Copyright (c) 2015年 木藤 紘介. All rights reserved.
//

import UIKit

class CircularRevealAnimator : NSObject {
    private let center: CGPoint
    private let duration: NSTimeInterval
    private let spreading: Bool
    
    init(center: CGPoint, duration: NSTimeInterval, spreading: Bool) {
        self.center = center
        self.duration = duration
        self.spreading = spreading
    }
}

extension CircularRevealAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let source = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let target = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // 画面全体を覆う円の半径
        let radius = { () -> CGFloat in
            let x = max(self.center.x, containerView.frame.width - self.center.x)
            let y = max(self.center.y, containerView.frame.height - self.center.y)
            
            return sqrt(x * x + y * y)
        }()
        
        let rectAroundCircle = { (radius: CGFloat) -> CGRect in
            return CGRectInset(CGRect(origin: self.center, size: CGSizeZero), -radius, -radius)
        }
        
        // アニメーションにおけるはじまりの円と終わりの円のパスを取得
        let startPath = CGPathCreateWithEllipseInRect(rectAroundCircle(0), nil)
        let endPath = CGPathCreateWithEllipseInRect(rectAroundCircle(radius), nil)
        
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let delegate = CircularRevealCompletion { () -> Void in
            transitionContext.completeTransition(true)
        }
        
        let substitutePathForMask = { (path: CGPath) -> CALayer in
            let mask = CAShapeLayer()
            mask.path = path
            
            return mask
        }
        
        if spreading {
            containerView.insertSubview(target, aboveSubview: source)
            let animation = CABasicAnimation(keyPath: "path", fromValue: startPath, toValue: endPath, duration: duration, timingFunction: timingFunction, delegate: delegate)
            target.layer.mask = substitutePathForMask(endPath)
            target.layer.mask.addAnimation(animation, forKey: "circular")
        } else {
            containerView.insertSubview(target, belowSubview: source)
            let animation = CABasicAnimation(keyPath: "path", fromValue: endPath, toValue: startPath, duration: duration, timingFunction: timingFunction, delegate: delegate)
            source.layer.mask = CAShapeLayer()
            source.layer.mask.addAnimation(animation, forKey: "circular")
        }
    }
}

class CircularRevealCompletion {
    private let completion: () -> Void
    
    init(completion: () -> Void) {
        self.completion = completion
    }
    
    dynamic func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        completion()
    }
}

extension CABasicAnimation {
    convenience init(keyPath: String!, fromValue: AnyObject, toValue: AnyObject, duration: CFTimeInterval, timingFunction: CAMediaTimingFunction, delegate: AnyObject) {
        self.init(keyPath: keyPath)
        
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.timingFunction = timingFunction
        self.delegate = delegate
    }
}
