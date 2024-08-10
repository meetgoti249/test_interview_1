//
//  StringValidation.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import Foundation

//// `Enum` fir validation options.
enum AllowCharacters {
case name,userName, email,password
    var characters:String {
        switch self {
        case .userName:
            return MatchCharacterConstant.capitalAlphabet + MatchCharacterConstant.smallAlphabet
        case .name:
            return MatchCharacterConstant.capitalAlphabet + MatchCharacterConstant.smallAlphabet + " "
        case .email:
            return MatchCharacterConstant.capitalAlphabet + MatchCharacterConstant.smallAlphabet + "@._" + MatchCharacterConstant.number
        case .password:
            return MatchCharacterConstant.capitalAlphabet + MatchCharacterConstant.smallAlphabet + MatchCharacterConstant.number + MatchCharacterConstant.spacialCharacter
        }
    }
    var emptyAlertConstant:String {
        switch self {
        case .userName:
            return AlertConstants.enterUserNameEmail
        case .name:
            return AlertConstants.enterAccountName
        case .email:
            return AlertConstants.enterUserNameEmail
        case .password:
            return AlertConstants.enterPassword
        }
    }
    var validateConstant:String {
        switch self {
        case .userName:
            return AlertConstants.enterValidUserName
        case .name:
            return AlertConstants.enterValidAccountName
        case .email:
            return AlertConstants.enterValidEmail
        case .password:
            return AlertConstants.enterValidPassword
        }
    }
}

//// `Class` for validate the value according to define `AllowCharacters`.
class StringValidation {

    var matchedCharacter:AllowCharacters
    var sourceString:String
    var onlyEmptyCheck:Bool
    
    init(matchedCharacter: AllowCharacters,string:String,onlyEmptyCheck:Bool = false) {
        self.matchedCharacter = matchedCharacter
        self.sourceString = string
        self.onlyEmptyCheck = onlyEmptyCheck
    }
    
    func validate() -> String {
        sourceString.isEmpty || self.onlyEmptyCheck ? self.matchedCharacter.emptyAlertConstant : self.matchCharacters(sourceString, matchCharacters: matchedCharacter.characters) ? matchedCharacter == .email ?  self.validEmail() ? ""  : self.matchedCharacter.validateConstant : matchedCharacter == .password ? self.isValidPassword() ? "" : self.matchedCharacter.validateConstant : "" : self.matchedCharacter.validateConstant
    }
    
    //// Match String with allowed Character
    func matchCharacters(_ string: String, matchCharacters characters: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: characters).inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
    
    //// Validate Email
    func validEmail() -> Bool {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,4})$" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid  = emailText.evaluate(with: self.sourceString) as Bool
        return isValid
    }
    //// Validate password
    func isValidPassword() -> Bool {
        let passwordRegix = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,16}$"
        let passwordText  = NSPredicate(format:"SELF MATCHES %@",passwordRegix)
        
        return passwordText.evaluate(with:self.sourceString)

    }
}


