//
//  LoginViewController.swift
//  nobitex-clone
//
//  Created by Majid Jamali on 2024/6/4.
//

import UIKit

class HeaderItemCollectionViewCell: UICollectionViewCell {
    
    let stack = UIStackView()
    let textView = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4.0
        stack.distribution = .equalCentering
        
        
        textView.font = .systemFont(ofSize: 12.0, weight: .semibold)
        textView.textColor = .mainText
        textView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(textView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        stack.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: stack, attribute: .width, multiplier: 0.0, constant: 20.0),
        ])
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        contentView.layer.setAffineTransform(.init(scaleX: -1, y: 1))
    }
    
    func layoutViews() {
        let minSize = frame.size
        let intercellSideSpacing = 8.0
        let imagesize = imageView.intrinsicContentSize.width
        let stackSize = textView.intrinsicContentSize.width + imagesize + stack.spacing + (intercellSideSpacing * 2)
        
        let width = stackSize > minSize.width ? stackSize : minSize.width
        let space = minSize.width - stackSize
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stack, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: stack, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: stack, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0.0, constant: minSize.height),
            
//            NSLayoutConstraint(item: stack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: intercellSideSpacing + space / 2),
//            NSLayoutConstraint(item: stack, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -(intercellSideSpacing + space / 2)),
            
            NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .width, multiplier: 0.0, constant: width),
        ])
        
//        if stackSize < minSize.width {
//            let space = minSize.width - stackSize
//            NSLayoutConstraint.activate([
//                
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                NSLayoutConstraint(item: stack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: intercellSideSpacing),
//                NSLayoutConstraint(item: stack, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: -intercellSideSpacing),
//            ])
//        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class LoginFormHeaderView: UIStackView {
    
    var headerItems = [FrameHeader]()
    
    private var timer: Timer? = nil
    private let frameTop = UIView()
    let cellIdentifier = "headerCell"
    private var headerCollection: UICollectionView? = nil
    
    init() {
        super.init(frame: .zero)
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        
        headerCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        headerCollection?.register(HeaderItemCollectionViewCell.self,
                                   forCellWithReuseIdentifier: cellIdentifier)
        headerCollection?.delegate = self
        headerCollection?.dataSource = self
        headerCollection?.backgroundColor = .clear
        headerCollection?.showsHorizontalScrollIndicator = false
        headerCollection?.layer.setAffineTransform(.init(scaleX: -1, y: 1))
        
        frameTop.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(frameTop)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: frameTop, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.0, constant: 50),
            NSLayoutConstraint(item: frameTop, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0),
        ])
        frameTop.layer.cornerRadius = 10.0
        frameTop.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        headerCollection?.translatesAutoresizingMaskIntoConstraints = false
        frameTop.addSubview(headerCollection!)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headerCollection!, attribute: .height, relatedBy: .equal, toItem: frameTop, attribute: .height, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: headerCollection!, attribute: .width, relatedBy: .equal, toItem: frameTop, attribute: .width, multiplier: 1.0, constant: 0.0),
        ])
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHeaders(headers: [FrameHeader]) {
        
        self.headerItems = headers
        frameTop.backgroundColor = headerItems[0].color.withAlphaComponent(0.25)
        headerCollection?.reloadData()
    }
}


extension LoginFormHeaderView: UICollectionViewDelegate,
                               UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        frameTop.frame.size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.headerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HeaderItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = headerItems[indexPath.item]
        cell.textView.text = item.title
        cell.imageView.image = UIImage(systemName: item.icon)
        cell.imageView.tintColor = item.color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? HeaderItemCollectionViewCell else {
            return
        }
        
        cell.layoutViews()
        
        let item = headerItems[indexPath.item]
        let bgAnimation = CABasicAnimation(keyPath: "backgroundColor")
        bgAnimation.duration = 1.0
        bgAnimation.fromValue = frameTop.backgroundColor
        bgAnimation.toValue = item.color.withAlphaComponent(0.25)
        bgAnimation.isRemovedOnCompletion = true
        frameTop.layer.add(bgAnimation, forKey: "colourAnimation")
        frameTop.backgroundColor = item.color.withAlphaComponent(0.25)
    }
}


class LoginFormView: UIStackView {
    
    let headers = [
        FrameHeader(title: "مطمئن شوید در دامنه رسمی نوبیتکس هستید", icon: "lock.shield", color: .warning),
        FrameHeader(title: "قیمت بیت کوین به بالای ۶۰ هزار دلار رسید", icon: "arrow.up.right", color: .hot),
        FrameHeader(title: "لطفا پس از ثبت نام احراز هویت کنید", icon: "person.fill.checkmark", color: .active),
    ]
    
    let topLogoView = LoginLogoView()
    let headerView = LoginFormHeaderView()
    
    init() {
        super.init(frame: .zero)
        
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .center
        self.spacing = 20
        
        topLogoView.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(topLogoView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(headerView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        ])
        
        headerView.addHeaders(headers: headers)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}






































class LoginViewController: UIViewController {
    
    let formView = LoginFormView()
    
    func createFormView() {
        
        view.addSubview(formView)
        formView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: formView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: formView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: formView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: -40.0),
        ])
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





























final class LoginLogoView: UIStackView {
    
    let image = UIImageView()
    let text = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        self.axis = .horizontal
        self.spacing = 12
        self.distribution = .fill
        
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        let text = UILabel()
        text.text = "NOBITEX"
        text.font = .systemFont(ofSize: 48.0, weight: .semibold)
        text.textColor = .mainTheme
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(image)
        self.addArrangedSubview(text)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.0, constant: 45.0),
            NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.0, constant: 45.0),
        ])
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
