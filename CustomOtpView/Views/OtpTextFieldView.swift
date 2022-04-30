//
//  OtpTextFieldVoew.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//
import SwiftUI
import Combine

public struct OtpTextFieldView: View {
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    @State var pin: String = ""
    var handler: (String, (Bool) -> Void) -> Void
    
    private var backgroundTextField: some View {
        return TextField("", text: $pin)
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .accentColor(.blue)
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) { _ in limitText(Constants.OTP_CODE_LENGTH) }
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
                        Text(self.getPin(at: index))
                            .font(Font.system(size: 27))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.textColorPrimary)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.textColorPrimary)
                            .padding(.trailing, 5)
                            .padding(.leading, 5)
                            .opacity(self.pin.count <= index ? 1 : 0)
                    }
                }
            }
        }
    }
    
    private func getPin(at index: Int) -> String {
        guard self.pin.count > index else {
            return ""
        }
        return self.pin[index]
    }
    
    private func limitText(_ upper: Int) {
        if pin.count > upper {
            pin = String(pin.prefix(upper))
        }
    }
}
