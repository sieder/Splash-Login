//
//  UserDefaults+helpers.swift
//  Splash Login
//
//  Created by Sieder Villareal on 3/25/18.
//  Copyright © 2018 Sieder Villareal. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }//safe
    
    func setIsLoggedIn(value: Bool) {
        set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
