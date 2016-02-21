# CircularRevealAnimator
Screen transition with scaling circle.

## Demo
![Preview](http://f.st-hatena.com/images/fotolife/k/kitoko552/20150624/20150624152856.gif)

## Usage
```swift
class ViewController: UIViewController {
    private var transitioner: Transitioner?
    var tapPoint: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        transitioner = Transitioner(style: .CircularReveal(tapPoint!), viewController: viewController)
    }
}

extension ViewController {
    @IBAction func buttonTapped(sender: UIButton) {
        transitioner = Transitioner(style: .CircularReveal(sender.center), viewController: self)
        dismissViewControllerAnimated(true, completion: nil)
    }
}
```

You can see the sample project under the Sample directory.

# Requirement
iOS8.0+

# License
The MIT License
