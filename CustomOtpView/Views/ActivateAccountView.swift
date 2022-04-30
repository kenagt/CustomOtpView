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
    }
    
    var phoneNumberDesc : some View {
        VStack(spacing: 0) {
            Text(LocalizedStringKey("sent.code.phone"))
                .font(Font.system(size: 15))
                .foregroundColor(Color.textColorPrimary)
            HStack(spacing: 1) {
                Text("\(phoneViewModel.phoneNumber)\(".")")
                    .font(Font.system(size: 15))
                    .fontWeight(.semibold)
                    .frame(width: nil, height: nil, alignment: .leading)
                    .foregroundColor(Color.textColorPrimary)
                NavigationLink(destination: PhoneSetupView(phoneViewModel: phoneViewModel), isActive: $showPhoneSetupView) {
                    Text(LocalizedStringKey("wrong.number"))
                        .font(Font.system(size: 15))
                        .foregroundColor(Color.textColor)
                }
            }
        }
        .padding(.top, 15)
    }
    
    var btnReactivate: some View {
        HStack {
            Button(action: {
                //Restart countdown timer
                phoneViewModel.startTimer()
                
                //Viewmodel func activate via call
            }) {
                Text(LocalizedStringKey("resend.sms"))
                    .foregroundColor(!phoneViewModel.timerExpired ? Color.btnColorDisabled : Color.textColor)
                    .font(Font.system(size: 17))
                    .fontWeight(.medium)
                    .frame(maxWidth: 150)
            }
            .padding(15)
            .cornerRadius(50)
            .disabled(!phoneViewModel.timerExpired)
            
            Button(action: {
                //Restart countdown timer
                phoneViewModel.startTimer()
                
                //Viewmodel func activate via call
            }) {
                Text(LocalizedStringKey("activate.via.call"))
                    .foregroundColor(!phoneViewModel.timerExpired ? Color.btnColorDisabled : Color.textColor)
                    .font(Font.system(size: 17))
                    .fontWeight(.medium)
                    .frame(maxWidth: 150)
            }
            .padding(15)
            .cornerRadius(50)
            .disabled(!phoneViewModel.timerExpired)
        }
    }
    
    var codeDigits: some View {
        VStack {
            Text(LocalizedStringKey("6.digit.code"))
                .font(Font.system(size: 25))
                .foregroundColor(Color.gray)
            OTPView()
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
