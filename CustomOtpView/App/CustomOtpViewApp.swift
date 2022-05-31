//
//  CustomOtpViewApp.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//

import SwiftUI
import Firebase

@main
struct CustomOtpViewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var phoneViewModel = PhoneViewModel()
    
    var body: some Scene {
        WindowGroup {
            ActivateAccountView(phoneViewModel: phoneViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("\(#function)")
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
    }
}
