//
//  PasswordDataModel.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import Foundation
import RealmSwift

//MARK: Protocol for validation process for the data
protocol PasswordValidation {
    /// Define Set of rules that define by inherited class.
    var validationRule:[StringValidation] { get }
    
}
extension PasswordValidation {
    
    /// Validate set of rules define in `validateRule`
    func validate() -> String {
        for rule in self.validationRule {
            let string = rule.validate()
            if (!string.isEmpty) {
                return string
            }
        }
        return ""
    }
}


class PasswordsInfo:ObservableObject,Equatable {
    
    /// Match the equality of the object
    static func == (lhs: PasswordsInfo, rhs: PasswordsInfo) -> Bool {
        lhs.id == rhs.id
    }
    
    var id:String
    var name:String
    @Published var userNameEmail:String
    @Published var password:String
    
    ///Initialize `PasswordInfo`
    init(id:String = UUID().uuidString,name: String, userNameEmail: String, password: String) {
        self.id = id
        self.name = name
        self.userNameEmail = userNameEmail
        self.password = password
    }
    
    //// Create `PasswordInfo` data from `PasswordDataModel` object.
    static func makePassword(_ dataModel:PasswordDataModel) -> PasswordsInfo {
        return PasswordsInfo(id: "\(dataModel._id )", name: dataModel.account_name, userNameEmail: dataModel.userNameEmail, password: dataModel.decryptedPassword)
    }

    //// Set Data for the realm data object `PasswordDataModel`.
    func setPasswordModel() -> PasswordDataModel {
        let passwordDataModel = PasswordDataModel()
        passwordDataModel.account_name = name
        passwordDataModel.password = encryptedPassword
        passwordDataModel.userNameEmail = userNameEmail
        return passwordDataModel
    }
    
    /// Get encrypted password
    /// if the encryption done successfully, then give encrypted password otherwise give the original value define in `password`.
    var encryptedPassword:String {
        if let encryptedPassword = PasswordEncryption(sourceString: password).encryptPassword() {
            return encryptedPassword
        }
        return self.password
    }
}

extension PasswordsInfo : PasswordValidation {
    
    ///Define validation rule
    var validationRule: [StringValidation] {
        get {
            var rules = [StringValidation(matchedCharacter: .name, string: self.name)]
            if (self.userNameEmail.contains("@")) {
                rules.append(StringValidation(matchedCharacter: .email, string: self.userNameEmail))
            } else {
                rules.append(StringValidation(matchedCharacter: .userName, string: self.userNameEmail))
            }
            rules.append(StringValidation(matchedCharacter: .password, string: self.password))
            return rules
        }
    }
}

class PasswordDataModel:Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var account_name:String
    @Persisted var userNameEmail:String
    @Persisted  var password:String
    
    /// Get decrypted password
    /// if the decryption done successfully, then give decrypted password otherwise give the original value define in `password`.
    
    var decryptedPassword : String {
        if let decryptedPassword = PasswordEncryption(sourceString: password).decryptPassword() {
            return decryptedPassword
        }
        return self.password
    }
    
    ///Set the updated value from `PasswordsInfo`.
    func updateData(_ data:PasswordsInfo)  {
        self.password = data.encryptedPassword
        self.account_name = data.name
        self.userNameEmail = data.userNameEmail
    }
}



