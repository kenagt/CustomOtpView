//
//  CountryModel.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 31. 5. 2022..
//

import Foundation

struct CountryModel: Codable, Identifiable {
    var id = UUID()
    var name: String
    var dial_code: String
    var code: String
    
    init(name: String, dial_code: String, code: String){
        self.name = name
        self.dial_code = dial_code
        self.code = code
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case dial_code
        case code
    }
}
