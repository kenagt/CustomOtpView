//
//  Extensions.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//

import Foundation

extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}
