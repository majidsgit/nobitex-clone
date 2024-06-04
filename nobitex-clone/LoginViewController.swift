//
//  LoginViewController.swift
//  nobitex-clone
//
//  Created by Majid Jamali on 2024/6/4.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var timer: Timer? = nil
    
    func topView() -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let text = UILabel()
        text.text = "NOBITEX"
        text.font = .systemFont(ofSize: 48.0, weight: .semibold)
        text.textColor = .mainTheme
        text.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(text)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: stack, attribute: .width, multiplier: 0.0, constant: 45.0),
            NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: stack, attribute: .height, multiplier: 0.0, constant: 45.0),
        ])
        
        return stack
    }
    
    func createFormView() {
        let formStack = UIStackView()
        formStack.axis = .vertical
        formStack.distribution = .equalSpacing
        formStack.alignment = .center
        formStack.spacing = 20
        
        let topView = topView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        formStack.addArrangedSubview(topView)
        
        let headers = [
            FrameHeader(title: "مطمئن شوید در دامنه رسمی نوبیتکس هستید", icon: "lock.shield", color: .warning),
            FrameHeader(title: "قیمت بیت کوین به بالای ۶۰ هزار دلار رسید", icon: "arrow.up.right", color: .hot),
            FrameHeader(title: "لطفا پس از ثبت نام احراز هویت کنید", icon: "person.fill.checkmark", color: .active),
        ]
        let formFrame = createFormFrameView(with: headers)
        formFrame.translatesAutoresizingMaskIntoConstraints = false
        formStack.addArrangedSubview(formFrame)
        
        formStack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(formStack)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: formStack, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: formStack, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: formStack, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: -40.0),
        ])
        
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: formFrame, attribute: .width, relatedBy: .equal, toItem: formStack, attribute: .width, multiplier: 1.0, constant: 0.0)
        ])
    }
    
    func createFormFrameView(with header: [FrameHeader]) -> UIView {
        let stack = UIStackView()
        stack.spacing = 0.0
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        
        if header.count != 0 {
            
            var item = header[0]
            
            let frameTop = UIView()
            frameTop.backgroundColor = item.color.withAlphaComponent(0.25)
            
            frameTop.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(frameTop)
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: frameTop, attribute: .height, relatedBy: .equal, toItem: stack, attribute: .height, multiplier: 0.0, constant: 50),
                NSLayoutConstraint(item: frameTop, attribute: .width, relatedBy: .equal, toItem: stack, attribute: .width, multiplier: 1.0, constant: 0.0),
            ])
            
            frameTop.layer.cornerRadius = 10.0
            frameTop.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            let headerTitleStack = UIStackView()
            headerTitleStack.axis = .horizontal
            headerTitleStack.alignment = .center
            headerTitleStack.spacing = 6.0
            headerTitleStack.distribution = .fill
            
            let textView = UILabel()
            textView.text = item.title
            textView.font = .systemFont(ofSize: 12.0, weight: .semibold)
            textView.textColor = .mainText
            textView.translatesAutoresizingMaskIntoConstraints = false
            headerTitleStack.addArrangedSubview(textView)
            
            let imageView = UIImageView(image: .init(systemName: item.icon))
            imageView.tintColor = item.color
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            headerTitleStack.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: headerTitleStack, attribute: .width, multiplier: 0.0, constant: 20.0),
            ])
            
            headerTitleStack.translatesAutoresizingMaskIntoConstraints = false
            frameTop.addSubview(headerTitleStack)
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: headerTitleStack, attribute: .centerX, relatedBy: .equal, toItem: frameTop, attribute: .centerX, multiplier: 1.0, constant: 0.0),
                NSLayoutConstraint(item: headerTitleStack, attribute: .centerY, relatedBy: .equal, toItem: frameTop, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            ])
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { t in
                if let index = header.firstIndex(where: { $0.title == item.title }) {
                    if index < header.count - 1 {
                        item = header[index + 1]
                    } else {
                        item = header[0]
                    }
                }
                
                let bgAnimation = CABasicAnimation(keyPath: "backgroundColor")
                bgAnimation.duration = 1.0
                bgAnimation.fromValue = frameTop.backgroundColor
                bgAnimation.toValue = item.color.withAlphaComponent(0.25)
                bgAnimation.isRemovedOnCompletion = true
                frameTop.layer.add(bgAnimation, forKey: "colourAnimation")
                frameTop.backgroundColor = item.color.withAlphaComponent(0.25)
                
                UIView.animate(withDuration: 1.0) {
                    textView.text = item.title
                    imageView.image = UIImage(systemName: item.icon)
                    imageView.tintColor = item.color
                }
                
            }
            
        }
        
        
        
        return stack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewControllers = self.navigationController?.viewControllers else {
            return
        }
        var allVCs = viewControllers
        allVCs.remove(at: 0)
        self.navigationController?.setViewControllers(allVCs, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .mainBackground
        navigationItem.hidesBackButton = true
        createFormView()
    }
}
