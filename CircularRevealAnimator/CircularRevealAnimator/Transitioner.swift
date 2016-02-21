//
//  Transitioner.swift
//  CircularRevealAnimator
//
//  Created by Kosuke Kito on 2016/02/20.
//  Copyright © 2016年 Kosuke Kito. All rights reserved.
//

import UIKit

enum TransitionStyle {
    case CircularReveal(CGPoint), Default
    
    var presentTransitioning: UIViewControllerAnimatedTransitioning? {
        switch self {
        case .CircularReveal(let point): return CircularRevealAnimator(center: point, isPresent: true)
        case .Default: return nil
        }
    }
    
    var dismissTransitioning: UIViewControllerAnimatedTransitioning? {
        switch self {
        case .CircularReveal(let point): return CircularRevealAnimator(center: point, isPresent: false)
        case .Default: return nil
        }
    }
}

class Transitioner: NSObject {
    private let style: TransitionStyle
    
    init(style: TransitionStyle, viewController: UIViewController) {
        self.style = style
        super.init()
        viewController.transitioningDelegate = self
    }
}

extension Transitioner: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return style.presentTransitioning
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return style.dismissTransitioning
    }
}