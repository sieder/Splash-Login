//
//  ViewController.swift
//  Splash Login
//
//  Created by Sieder Villareal on 3/2/18.
//  Copyright © 2018 Sieder Villareal. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
    func finishLoggingIn()
}

class LoginController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginControllerDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "Share a great Listen", message: "It's free to send your books to the people in your life. Every rexipient's first book is on us.", imageName: "page1")
        
        let secondPage = Page(title: "Send from your library", message: "Tap the more menu next to any book. Choose \"Send this book\"", imageName: "page2")
        
        let thirdPage = Page(title: "Send from the player", message: "Tap the more menu in the upper corner. Choose \"Send this book\"", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    @objc func nextPage() {
        if pageControl.currentPage == pages.count { //last page
            return
        }
        
        if pageControl.currentPage == pages.count - 1 { //second to the last page
            moveControlConstraintsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    @objc func skipPage() {
        //we only need two lines to this
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        setupConstraints()
        registerCells()
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)

    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        //we are on the last page
        if pageNumber == pages.count {
            print("Animate controls off screen")
            moveControlConstraintsOffScreen()
        } else {
            pageControlBottomAnchor?.constant = -20
            nextButtonTopAnchor?.constant = 25
            skipButtonTopAnchor?.constant = 25
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 20
        nextButtonTopAnchor?.constant = -40
        skipButtonTopAnchor?.constant = -40
    }
    
    fileprivate func registerCells() {
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func setupConstraints() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        var bottomArrayAnchorConstraints = [NSLayoutConstraint]()
        var nextArrayAnchorConstraints = [NSLayoutConstraint]()
        var skipArrayAnchorConstraints = [NSLayoutConstraint]()
        
        bottomArrayAnchorConstraints.append(pageControl.leftAnchor.constraint(equalTo: view.leftAnchor))
        bottomArrayAnchorConstraints.append(pageControl.rightAnchor.constraint(equalTo: view.rightAnchor))
        bottomArrayAnchorConstraints.append(pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20))
        bottomArrayAnchorConstraints.append(pageControl.heightAnchor.constraint(equalToConstant: 30))
        bottomArrayAnchorConstraints.forEach{($0.isActive = true)}
        pageControlBottomAnchor = bottomArrayAnchorConstraints[2]
        
        skipArrayAnchorConstraints.append(skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25))
        skipArrayAnchorConstraints.append(skipButton.leftAnchor.constraint(equalTo: view.leftAnchor))
        skipArrayAnchorConstraints.append(skipButton.widthAnchor.constraint(equalToConstant: 60))
        skipArrayAnchorConstraints.append(skipButton.heightAnchor.constraint(equalToConstant: 50))
        skipArrayAnchorConstraints.forEach{($0.isActive = true)}
        skipButtonTopAnchor = skipArrayAnchorConstraints[0]
        
        nextArrayAnchorConstraints.append(nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25))
        nextArrayAnchorConstraints.append(nextButton.rightAnchor.constraint(equalTo: view.rightAnchor))
        nextArrayAnchorConstraints.append(nextButton.widthAnchor.constraint(equalToConstant: 60))
        nextArrayAnchorConstraints.append(nextButton.heightAnchor.constraint(equalToConstant: 50))
        nextArrayAnchorConstraints.forEach{($0.isActive = true)}
        nextButtonTopAnchor = nextArrayAnchorConstraints[0]
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //we're rendering our last login cell
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    func finishLoggingIn() {
        //implement home controller
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        mainNavigationController.viewControllers = [HomeController()]
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize() //saving the value to the device
        
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        
        //scroll to indexpath after the rotation is going
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
  
    }

}















