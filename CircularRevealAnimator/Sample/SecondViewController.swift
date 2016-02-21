//
//  SecondViewController.swift
//  CircularRevealAnimator
//
//  Created by Kosuke Kito on 2015/06/23.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    private var transitioner: Transitioner?
    
    class func instantiate(point: CGPoint) -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier("Second") as! SecondViewController
        viewController.transitioner = Transitioner(style: .CircularReveal(point), viewController: viewController)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SecondViewController {
    @IBAction func buttonTapped(sender: UIButton) {
        transitioner = Transitioner(style: .CircularReveal(sender.center), viewController: self)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
