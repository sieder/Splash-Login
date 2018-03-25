//
//  HomeController.swift
//  Splash Login
//
//  Created by Sieder Villareal on 3/25/18.
//  Copyright © 2018 Sieder Villareal. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        navigationItem.title = "We are logged in"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        
        let btnHome = UIButton(type: .system)
        btnHome.setTitle("TEST", for: .normal)
        btnHome.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btnHome)
        
        btnHome.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        btnHome.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        btnHome.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        btnHome.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}
