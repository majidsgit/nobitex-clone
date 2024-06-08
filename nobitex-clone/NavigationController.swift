//
//  NavigationController.swift
//  nobitex-clone
//
//  Created by Majid Jamali on 2024/6/4.
//

import UIKit

class NavigationController: UIViewController {
    
    var isLoadingDone: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] t in
            if self?.isLoadingDone ?? false {
                self?.loadViewByUserSession()
                t.invalidate()
            } else {
                self?.isLoadingDone = true
            }
        }.fire()
    }

    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .mainBackground
        navigationItem.hidesBackButton = true
        openingAnimation()
    }
    
    // remove back button
    
    
    // loading Animation
    func openingAnimation() {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
        ])
        addAnimation(to: imageView)
    }
    
    func addAnimation(to animatedView: UIView) {
        
        animatedView.layer.shadowRadius = 0
        animatedView.layer.shadowColor = UIColor.mainTheme.withAlphaComponent(0.5).cgColor
        animatedView.layer.shadowOffset = CGSize(width: 3, height: 3)
        animatedView.layer.shadowOpacity = 0.5
        
        let layerAnimation = CABasicAnimation(keyPath: "shadowRadius")
        layerAnimation.fromValue = 0.0
        layerAnimation.toValue = 15.0
        layerAnimation.isAdditive = true
        layerAnimation.duration = CFTimeInterval(3.0)
        layerAnimation.fillMode = CAMediaTimingFillMode.forwards
        layerAnimation.isRemovedOnCompletion = false
        animatedView.layer.add(layerAnimation, forKey: "addGlowing")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // if(logged_in): MainViewController
    // else: LoginViewController
    func loadViewByUserSession() {
        let isLoggedIn = false
        let newViewController = isLoggedIn ? MainViewController() : LoginViewController()
        self.show(newViewController, sender: self)
    }
}
