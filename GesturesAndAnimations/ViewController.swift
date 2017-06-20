//
//  ViewController.swift
//  GesturesAndAnimations
//
//  Created by Sam Meech-Ward on 2017-06-19.
//  Copyright © 2017 Sam Meech-Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var box: UIView!
    var timesRotated = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func viewTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.randomSize(self.box)
            self.box.backgroundColor = self.randomColor()
        }) { (done) in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.box.alpha = 0.0
            }, completion: { (done) in
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                    self.box.alpha = 1.0
                }, completion: nil)
            })
            
        }
        
//        timesRotated += 1
//        rotateBox(radians: CGFloat.pi*CGFloat(timesRotated))
    }
    
    func randomSize(_ view: UIView) {
        let viewWidth = view.frame.width
        var inset: CGFloat = 0.0
        
        if (viewWidth < 100) {
            inset = -50
        } else {
            inset = CGFloat(arc4random_uniform(UInt32(UInt(viewWidth / 4.0)))) + viewWidth / 4.0
            inset = arc4random_uniform(2) == 1 ? inset : inset * -1
        }
        
        let newFrame = view.frame.insetBy(dx: inset, dy: inset)
        view.frame = newFrame
    }
    
    func rotateBox(radians: CGFloat) {
        
        UIView.animate(withDuration: 3.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.box.transform = CGAffineTransform(rotationAngle: radians)
            
        }, completion: { (done) in
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .autoreverse, animations: {
                self.box.backgroundColor = self.randomColor()
            }, completion: nil)
        })
        
        UIView.animate(withDuration: 1.0) {
            
        }
    }
    
    func randomColor() -> UIColor {
        func randomDecimal() -> Float {
            return Float(arc4random_uniform(1000)) / 1000.0
        }
        
        return UIColor(colorLiteralRed: randomDecimal(), green: randomDecimal(), blue: randomDecimal(), alpha: 1.0)
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        
        let delta = sender.translation(in:view.superview)
        var center = view.center
        center.x += delta.x
        center.y += delta.y
        view.center = center
        sender.setTranslation(.zero, in: view.superview)
    }
    
    @IBAction func didRotate(_ sender: UIRotationGestureRecognizer) {
        rotateBox(radians: sender.rotation)
    }
}

