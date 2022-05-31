//
//  ContentView.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//

import SwiftUI

struct ActivateAccountView: View {
    //MARK: vars
    @State var otpCode = ""
    @State private var showPhoneSetupView = false
    @ObservedObject var phoneViewModel: PhoneViewModel
    
    //MARK: init
    init(phoneViewModel: PhoneViewModel){
        self.phoneViewModel = phoneViewModel
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "barTintColor")
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        Utils.shared.requestUserNotifications()
    }
    
    var phoneNumberDesc : some View {
        VStack(spacing: 0) {
            Text("Resend code.")
                .font(Font.system(size: 15))
                .foregroundColor(Color.textColorPrimary)
            HStack(spacing: 1) {
                Text("\(phoneViewModel.phoneNumber)\(".")")
                    .font(Font.system(size: 15))
                    .fontWeight(.semibold)
                    .frame(width: nil, height: nil, alignment: .leading)
                    .foregroundColor(Color.textColorPrimary)
                Text(LocalizedStringKey("Wrong number?"))
                    .font(Font.system(size: 15))
                    .foregroundColor(Color.textColor)
            }
        }
        .padding(.top, 15)
    }
    
    var btnReactivate: some View {
        Button(action: {
            //Restart countdown timer
            phoneViewModel.startTimer()
        }) {
            Text("Resend SMS")
                .foregroundColor(!phoneViewModel.timerExpired ? Color.btnColorDisabled : Color.textColor)
                .font(Font.system(size: 17))
                .fontWeight(.medium)
                .frame(maxWidth: 150)
        }
        .padding(15)
        .cornerRadius(50)
        .disabled(!phoneViewModel.timerExpired)
    }
    
    var codeDigits: some View {
        VStack {
            Text("6 digit code")
                .font(Font.system(size: 25))
                .foregroundColor(Color.gray)
            OTPTextFieldView(phoneViewModel: phoneViewModel)
                .padding(.leading, 55)
                .padding(.trailing, 55)
            CountDownView(phoneViewModel: phoneViewModel)
                .padding(.top, 25)
            btnReactivate
                .padding(.top, 35)
        }
        .padding(.top, 35)
    }
    
    //MARK: Body
    var body: some View {
        VStack {
            LinearProgressBarView(phoneViewModel: phoneViewModel)
            phoneNumberDesc
            codeDigits
            Spacer()
        }
        .background(Color.backgroundColor)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(LocalizedStringKey("activate.account"), displayMode: .inline)
        .onAppear { phoneViewModel.requestVerificationID() }
    }
}

struct ActivateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivateAccountView(phoneViewModel: PhoneViewModel()).environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            ActivateAccountView(phoneViewModel: PhoneViewModel()).environment(\.colorScheme, .dark).previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            ActivateAccountView(phoneViewModel: PhoneViewModel()).environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            ActivateAccountView(phoneViewModel: PhoneViewModel()).environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            ActivateAccountView(phoneViewModel: PhoneViewModel()).environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            ActivateAccountView(phoneViewModel: PhoneViewModel()).environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        }
    }
}
