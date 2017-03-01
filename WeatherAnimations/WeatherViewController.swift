//
//  ViewController.swift
//  WeatherAnimations
//
//  Created by Ian Rahman on 10/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    
    let sun = UIImageView(image: UIImage(named: "Sun"))
    let moon = UIImageView(image: UIImage(named: "Moon"))
    let cloud = UIImageView(image: UIImage(named: "Cloud"))
    let lightning = UIImageView(image: UIImage(named: "Lightning"))
    
    let cloudsButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sun)
        self.view.addSubview(moon)
        self.view.addSubview(cloud)
        self.view.addSubview(moon)
        self.view.addSubview(lightning)
        
        
        
        
        for view in self.view.subviews {
            view.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
        }
        self.view.addSubview(self.cloudsButton)
        cloudsButton.frame = CGRect(x: UIScreen.main.bounds.width * 0.5 - 15, y: UIScreen.main.bounds.height * 0.75, width: 30, height: 30)
        cloudsButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        cloudsButton.setImage(UIImage(named: "Cloud"), for: .normal)
        self.cloud.translatesAutoresizingMaskIntoConstraints = false
        self.cloud.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.cloud.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.cloud.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        self.cloud.heightAnchor.constraint(equalTo: self.cloud.widthAnchor, multiplier: 0.75).isActive = true
        
        self.lightning.translatesAutoresizingMaskIntoConstraints = false
        self.lightning.topAnchor.constraint(equalTo: self.cloud.bottomAnchor, constant: 10).isActive = true
        self.lightning.centerXAnchor.constraint(equalTo: self.cloud.centerXAnchor).isActive = true
        self.lightning.widthAnchor.constraint(equalTo: self.cloud.widthAnchor, multiplier: 0.5).isActive = true
        self.lightning.heightAnchor.constraint(equalTo: self.cloud.heightAnchor).isActive = true
        
        self.lightning.alpha = 0
        self.cloud.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animateSky()
    }
    
    func buttonAction() {
        self.cloud.alpha = 1
        for _ in 0...100 {
            let raindrop = UIImageView(image: UIImage(named: "raindrop"))
            self.view.addSubview(raindrop)
            raindrop.frame = CGRect(x: (CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.width)))), y: ((CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.height))))) * -1, width: 20, height: 20)
            UIView.animate(withDuration: 10, animations: { _ in
                raindrop.frame.origin.y += UIScreen.main.bounds.height * 2
            })
        }
        
        UIView.animateKeyframes(withDuration: 10, delay: 0, options: .allowUserInteraction, animations: {
            
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 5, animations: {
                self.cloud.frame.origin.y -= 150
                self.lightning.frame.origin.y -= 150
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/5, relativeDuration: 0.1, animations: {
                self.lightning.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 3/10, relativeDuration: 0.1, animations: {
                self.lightning.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 0.1, animations: {
                self.lightning.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 3/5, relativeDuration: 0.1, animations: {
                self.lightning.alpha = 0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 4/5, relativeDuration: 0.1, animations: {
                self.lightning.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 9/10, relativeDuration: 0.1, animations: {
                self.lightning.alpha = 0
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 5, animations: {
                self.cloud.frame.origin.y += 150
                self.lightning.frame.origin.y += 150
            })
            
            self.cloud.alpha = 0
            
        }, completion: nil)
    }
    
    
    func animateSky() {
        UIView.animate(withDuration: 3, delay: 0, options: .allowUserInteraction, animations: { _ in
            self.view.backgroundColor = UIColor.blue
            self.sun.frame.origin = CGPoint(x: UIScreen.main.bounds.width * 0.5 - self.sun.frame.width * 0.5, y: UIScreen.main.bounds.height * 0.1)
        }, completion: { _ in
            UIView.animate(withDuration: 3, delay: 0, options: .allowUserInteraction, animations: { _ in
                self.view.backgroundColor = UIColor.cyan
                self.sun.frame.origin = CGPoint(x: 0 - self.sun.frame.width * 0.5, y: UIScreen.main.bounds.height)
                self.moon.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 3, delay: 0, options: .allowUserInteraction, animations: {
                    self.setSun()
                    self.view.backgroundColor = UIColor.black
                    self.moon.frame.origin = CGPoint(x: UIScreen.main.bounds.width * 0.5 - self.sun.frame.width * 0.5, y: UIScreen.main.bounds.height * 0.1)
                }, completion: { _ in
                    UIView.animate(withDuration: 0, delay: 0, options: .allowUserInteraction, animations: { _ in
                        self.moon.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
                    }, completion: { _ in
                        self.animateSky()
                    })
                })
            })
        })
    }
    
    func setSun() {
        self.sun.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height)
    }
    
    
}
