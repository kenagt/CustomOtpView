//
//  OtpTextFieldVoew.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//
import SwiftUI
import Combine

public struct OTPTextFieldView: View {
    enum FocusField: Hashable {
        case field
    }
    @ObservedObject var phoneViewModel: PhoneViewModel
    @FocusState private var focusedField: FocusField?
    
    init(phoneViewModel: PhoneViewModel){
        self.phoneViewModel = phoneViewModel
        UITextField.appearance().clearButtonMode = .never
        UITextField.appearance().tintColor = UIColor.clear
    }
    
    private var backgroundTextField: some View {
        return TextField("", text: $phoneViewModel.verificationCode)
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .accentColor(.blue)
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(phoneViewModel.verificationCode)) { _ in phoneViewModel.limitText(Constants.OTP_CODE_LENGTH) }
            .focused($focusedField, equals: .field)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                {
                    self.focusedField = .field
                }
            }
            .padding()
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            backgroundTextField
            HStack {
                ForEach(0..<Constants.OTP_CODE_LENGTH) { index in
                    ZStack {
                        Text(phoneViewModel.getPin(at: index))
                            .font(Font.system(size: 27))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.textColorPrimary)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.textColorPrimary)
                            .padding(.trailing, 5)
                            .padding(.leading, 5)
                            .opacity(phoneViewModel.verificationCode.count <= index ? 1 : 0)
                    }
                }
            }
        }
    }
}
