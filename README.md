# Chain-Animator

As Writing an Animation block is quite easy as UIKit provides us many constructors for writing the view based animations using UIView.animate function, but when it comes to write multiple animations ie one after another then it become a chain of closures 🙈 ie we write another animation in the completion block of animation and so on... eg
```
 UIView.animate(withDuration: 0.5, animations: {
            rdView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (comp) in
            UIView.animate(withDuration: 0.4, animations: {
                rdView.transform = CGAffineTransform(translationX: 100, y: 1)
            }, completion: { (comp) in
                UIView.animate(withDuration: 0.7, animations: {
                    
                }, completion: { (comp) in
                    
                })
             })
         }
```
🧐Quite difficult to read and modify when some one ask us "hey please remove the scale and add fade animation" then we need to dig into the completion handlers to find the scale animation and change that, mann.

This little Helper classes can solve the problem of Animation chaining ie when it comes to write multiple animations then we just simply add in the animation array and create an new animation method behaviour thats all man 👍😎.

```
struct Animation {
    var duration:TimeInterval
    var closure:((UIView)->())
}

extension Animation {
    
    static func scale(duration:TimeInterval) -> Animation {
        return Animation(duration: duration, closure: { (myView) in
            myView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        })
    }
     static func translate(duration:TimeInterval,points:CGPoint) -> Animation {
        return Animation(duration: duration, closure: { (view) in
            view.transform = CGAffineTransform(translationX: points.x, y: points.y)
        })
    }
    
}

extension UIView {
    
    func animate(animations:[Animation]) {
         guard !animations.isEmpty else {return}
        var allAnimations = animations
        let currentAnimation = allAnimations.removeFirst()
        UIView.animate(withDuration: currentAnimation.duration, animations: {
            currentAnimation.closure(self)
        }) { (comp) in
            self.animate(animations: allAnimations)
        }
    }
}

```

Now what we need to do is just use this little UIView extension and call its animation function to perfom the animation chaning like this..

```
redView.animate(animations: [.scale(duration: 1),.translate(duration: 1, points: CGPoint(x: 60, y: 0))])

```

Enjoy 😎
