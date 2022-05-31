//
//  CustomUserDefaults.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 31. 5. 2022..
//

import Foundation

class CustomUserDefaults {
    static var shared = CustomUserDefaults()
    
    func setPushNotifications(enable: Bool) {
        let defaults = UserDefaults.standard
                
        defaults.set(enable, forKey: Constants.PUSH_NOTIFCATIONS)
        defaults.synchronize()
    }
    
    func getPushNotifications() -> Bool {
        let defaults = UserDefaults.standard
                
        defaults.synchronize()
        return defaults.bool(forKey: Constants.PUSH_NOTIFCATIONS)
    }
}
