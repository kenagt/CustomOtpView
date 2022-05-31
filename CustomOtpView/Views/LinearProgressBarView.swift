//
//  LinearProgressBarView.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//

import SwiftUI

struct LinearProgressBarView: View {
    @State private var offset: CGFloat = CGFloat(Constants.COUNTDOWN_TIMER_LENGTH)
    @ObservedObject var phoneViewModel: PhoneViewModel
    
    init(phoneViewModel: PhoneViewModel){
        self.phoneViewModel = phoneViewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.5)
                    .foregroundColor(Color.progressBarBackground)
                
                Rectangle()
                    .frame(width: (CGFloat(offset - CGFloat(phoneViewModel.timeRemaining)) * geometry.size.width)/offset, height: geometry.size.height)
                    .foregroundColor(Color.progressBarFill)
                    .animation(Animation.linear(duration: 1.0), value: offset)
            }.cornerRadius(45.0)
        }
        .frame(height: 5)
    }
}

