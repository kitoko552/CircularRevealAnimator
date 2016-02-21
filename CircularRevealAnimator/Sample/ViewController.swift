//
//  ViewController.swift
//  CircularRevealAnimator
//
//  Created by Kosuke Kito on 2015/06/23.
//  Copyright (c) 2015年 Kosuke Kito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(sender: UIButton) {
        let viewController = SecondViewController.instantiate(sender.center)
        presentViewController(viewController, animated: true, completion: nil)
    }
}

