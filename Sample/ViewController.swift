//
//  ViewController.swift
//  CircularRevealAnimator
//
//  Created by 木藤 紘介 on 2015/06/23.
//  Copyright (c) 2015年 木藤 紘介. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tapPoint: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        tapPoint = sender.center
        performSegueWithIdentifier("toSecondView", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let next = segue.destinationViewController as? SecondViewController {
            if let p = tapPoint {
                next.animator = CircularRevealAnimator(center: p, duration: 0.5, spreading: true)
            }
        }
    }
}

