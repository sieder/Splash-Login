//
//  ViewController.swift
//  Splash Login
//
//  Created by Sieder Villareal on 3/2/18.
//  Copyright © 2018 Sieder Villareal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        return button
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
        registerCells()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
//        pageControl.isEnabled = false
        
        //we are on the last page
        if pageNumber == pages.count {
            print("Animate controls off screen")
            pageControlBottomAnchor?.constant = 20
            nextButtonTopAnchor?.constant = -40
            skipButtonTopAnchor?.constant = -40
            
        } else {
            pageControlBottomAnchor?.constant = -20
            nextButtonTopAnchor?.constant = 25
            skipButtonTopAnchor?.constant = 25
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    fileprivate func registerCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
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
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }

}

