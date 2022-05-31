//
//  PhoneViewModel.swift
//  CustomOtpView
//
//  Created by Kenan Begić on 22. 4. 2022..
//
import Foundation
import PromiseKit

class PhoneViewModel: ObservableObject {
    //MARK: vars
    var authViewModel = AuthViewModel()
    var nowDate = Date()
    let referenceDate = Date(timeIntervalSinceNow:(1 * 5.0))
    @Published var verificationCode = ""
    @Published var verificationID = ""
    @Published var phoneNumber = "61829502"
    @Published var countryCodeNumber = "+387"
    @Published var country = ""
    @Published var code = ""
    @Published var timerExpired = false
    @Published var timeStr = ""
    @Published var timeRemaining = 60
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    //MARK: init
    init() {
        getCountryCodeForLocale()
    }
    
    //MARK: functions
    func getCurrentRegionCode() {
        countryCodeNumber = Locale.current.regionCode!.uppercased()
    }
    
    func getCountryCodeForLocale() {
        var countryCodes = [CountryModel]()
        getCurrentRegionCode()
        let countryCodesPath = Bundle.main.path(forResource: "CountryCodes", ofType: "json")!
        
        do {
            let fileCountryCodes = try? String(contentsOfFile: countryCodesPath).data(using: .utf8)!
            let decoder = JSONDecoder()
            countryCodes = try decoder.decode([CountryModel].self, from: fileCountryCodes!)
        }
        catch {
            print(error)
        }
        country = countryCodes.filter { $0.code == countryCodeNumber }.first?.name ?? ""
        code = countryCodes.filter { $0.code == countryCodeNumber }.first?.code ?? ""
        countryCodeNumber = countryCodes.filter { $0.code == countryCodeNumber }.first?.dial_code ?? ""
    }
    
    func selectCountryCode(selectedCountry: CountryModel){
        countryCodeNumber = selectedCountry.dial_code
        country = selectedCountry.name
        code = selectedCountry.code
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        timeRemaining = 60
        timerExpired = false
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        //Start new round of verification
        self.verificationCode = ""
        requestVerificationID()
    }

    func countDownString() {
        guard (timeRemaining > 0) else {
            self.timer.upstream.connect().cancel()
            timerExpired = true
            timeStr = String(format: "%02d:%02d", 00,  00)
            return
        }
        
        timeRemaining -= 1
        timeStr = String(format: "%02d:%02d", 00, timeRemaining)
    }
    
    func getPin(at index: Int) -> String {
        guard self.verificationCode.count > index else {
            return ""
        }
        return self.verificationCode[index]
    }
    
    func limitText(_ upper: Int) {
        if verificationCode.count > upper {
            verificationCode = String(verificationCode.prefix(upper))
        }
    }
    
    func requestVerificationID(){
        firstly {
            authViewModel.signUp(phoneNumber: "\(self.countryCodeNumber)\("")\(self.phoneNumber)")
        }.done(on: DispatchQueue.main) { verificationID in
            self.verificationID = verificationID
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }
    
    func authenticate(){
        let backgroundQueue = DispatchQueue.global(qos: .background)
        
        firstly {
            authViewModel.signIn(verificationID: self.verificationID, verificationCode: self.verificationCode)
        }.done(on: backgroundQueue) { (AuthDataResult) in
            
        }.catch { (error) in
            print(error.localizedDescription)
        }
    }
}
