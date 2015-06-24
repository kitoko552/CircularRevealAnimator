//
//  SecondViewController.swift
//  CircularRevealAnimator
//
//  Created by 木藤 紘介 on 2015/06/23.
//  Copyright (c) 2015年 木藤 紘介. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var animator: CircularRevealAnimator?
    var tapPoint: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {        
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let p = tapPoint {
            return CircularRevealAnimator(center: p, duration: 0.5, spreading: false)
        }
        
        return nil
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        tapPoint = sender.center
        dismissViewControllerAnimated(true, completion: nil)
    }
}
