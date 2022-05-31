//
//  CountDownView.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//

import SwiftUI

struct CountDownView : View {
    @ObservedObject var phoneViewModel: PhoneViewModel
    
    init(phoneViewModel: PhoneViewModel){
        self.phoneViewModel = phoneViewModel
    }
    
    var body: some View {
        Text(phoneViewModel.timeStr)
            .font(Font.system(size: 15))
            .foregroundColor(Color.textColorGray)
            .fontWeight(.semibold)
            .onReceive(phoneViewModel.timer) { _ in
                phoneViewModel.countDownString()
            }
    }
}
