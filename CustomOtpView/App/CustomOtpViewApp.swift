//
//  CustomOtpViewApp.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//

import SwiftUI

@main
struct CustomOtpViewApp: App {
    @StateObject var phoneViewModel = PhoneViewModel()
    
    var body: some Scene {
        WindowGroup {
            ActivateAccountView(phoneViewModel: phoneViewModel)
        }
    }
}
