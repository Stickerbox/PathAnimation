//
//  ViewController.swift
//  PathAnimation
//
//  Created by Jordan.Dixon on 08/08/2017.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func handleTap(gesture: UITapGestureRecognizer) {

        var views = [UIImageView]()
        (0...10).forEach { _ in views.append(UIImageView(image: #imageLiteral(resourceName: "unnamed"))) }
        
        performPathAnimation(for: views, in: view)
    }
    
}

extension UIViewController {
    
    func performPathAnimation(for childViews: [UIView], in parentView: UIView) {

        let randomStartPoint = CGFloat(arc4random_uniform(UInt32(parentView.frame.height)))
        let randomEndPoint = CGFloat(arc4random_uniform(UInt32(parentView.frame.height)))
        
        for childView in childViews {
            generateAnimatedViews(startPoint: randomStartPoint, endPoint: randomEndPoint, for: childView, in: parentView)
        }
    }
    
    private func generateAnimatedViews(startPoint: CGFloat, endPoint: CGFloat, for childView: UIView, in parentView: UIView) {
        
        let dimention = 20 + drand48() * 10 // generate a side length between 20 and 30
        childView.frame = CGRect(x: 0, y: 0, width: dimention, height: dimention)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = customPath(startPoint: startPoint, endPoint: endPoint).cgPath
        animation.duration = 2 + drand48() * 2 // generate a random length between 2 and 4 seconds
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        childView.layer.add(animation, forKey: nil)
        
        parentView.addSubview(childView)
    }
    
    private func customPath(startPoint: CGFloat, endPoint: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        let startPoint = CGPoint(x: 0, y: startPoint)
        let endPoint = CGPoint(x: view.frame.width + 30, y: endPoint)
        
        let randomYShift = 200 + drand48() * 300 // between 200 and 500
        let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
        let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
        
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return path
    }
}
