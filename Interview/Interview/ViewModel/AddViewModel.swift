//
//  AddViewModel.swift
//  Interview
//
//  Created by Meet Goti on 10/08/24.
//

import Foundation
class AddViewModel: ObservableObject {
    @Published var name:String = ""
    @Published var password:String = ""
    @Published var userNameEmail:String = ""
    var passwordData : PasswordsInfo = PasswordsInfo(name: "", userNameEmail: "", password: "") {
        didSet {
            self.name = passwordData.name
            self.password = passwordData.password
            self.userNameEmail = passwordData.userNameEmail
        }
    }
    
    func setValue() -> Void {
        passwordData.name = name
        passwordData.userNameEmail = userNameEmail
        passwordData.password = password
        return
    }
    func resetValue() -> Void {
        passwordData =  PasswordsInfo(name: "", userNameEmail: "", password: "")
        return
    }
}
