//
//  MainNavigationController.swift
//  Splash Login
//
//  Created by Sieder Villareal on 3/21/18.
//  Copyright © 2018 Sieder Villareal. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        if isLoggedIn() {
            //assume user is logged in
            let homeController = HomeController()
            viewControllers = [homeController]
            
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true) {
            //do something letter
        }
    }
}



