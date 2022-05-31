//
//  AuthViewModel.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 31. 5. 2022..
//

import Foundation
import PromiseKit
import Firebase

class AuthViewModel: ObservableObject {
    func signUp(phoneNumber: String) -> Promise<String> {
        return AuthenticationService.signUp(phoneNumber: phoneNumber)
    }

    func signIn(verificationID: String, verificationCode: String) -> Promise<AuthDataResult> {
        return AuthenticationService.signIn(verificationID: verificationID, verificationCode: verificationCode)
    }

    func signOut(){
        AuthenticationService.signOut()
    }
}
