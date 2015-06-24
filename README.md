# CircularRevealAnimator
円が広がるようにして次の画面に遷移する、画面遷移におけるAnimatorです。

## Description
タップしたところを起点に、円が広がるようにして画面遷移することができます。  
逆に、タップしたところを中心に、円が小さくなるようにして画面遷移することも可能です。  
durationは指定できます。

## Demo
![Preview](http://f.st-hatena.com/images/fotolife/k/kitoko552/20150624/20150624152856.gif)

## Usage
遷移先のViewControllerにUIViewControllerTransitioningDelegateを適用させ、以下のように設定します。

```swift
class SecondViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var animator: CircularRevealAnimator?
    var tapPoint: CGPoint?

    // ...

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 遷移元のViewControllerでインスタンス化したものを、
        // prepareForSegueでこちらに渡している。
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let p = tapPoint {
            // タップしたところは、IBActionのイベントなどで取得する。
            return CircularRevealAnimator(center: p, duration: 0.5, spreading: false)
        }

        return nil
    }

    // ...
}
```

Sampleディレクトリに実際の例があります。
