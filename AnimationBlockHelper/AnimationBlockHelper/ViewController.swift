//
//  ViewController.swift
//  AnimationBlockHelper
//
//  Created by Mukul Bakshi on 25/06/19.
//  Copyright © 2019 Coder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let rdView:UIView =  {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            myView.backgroundColor = UIColor.red
            myView.center = view.center
            return myView
        }()
        view.addSubview(rdView)
        
        rdView.animate(animations: [.scale(duration: 1),.translate(duration: 1, points: CGPoint(x: 60, y: 0))])
    }
    
}

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
