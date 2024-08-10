//
//  StringConstant.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import Foundation

struct MatchCharacterConstant {
    static let capitalAlphabet      = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let smallAlphabet        = "abcdefghijklmnopqrstuvwxyz"
    static let spacialCharacter     = "@._!#$%^&*()/<>'+,:;=?[]{}|~`-\""
    static let number               = "0123456789"
    static let timing               = number + ":"
    static let cardExpiration       = number + "/"
    static let date       = number + "-"
}

struct AlertConstants {
    static let enterAccountName : String = "Enter account name of your password."
    static let enterValidAccountName : String = "The account name does not contain any special characters or numbers."
    static let enterUserNameEmail : String = "Enter username or email for your password."
    static let enterValidUserName : String = "Enter valid username or email for your password."
    static let enterValidEmail : String = "Enter valid email."
    static let enterPassword : String = "Enter your password."
    static let enterValidPassword : String = "Password should contains minimum 8 characters at least 1 Uppercase, 1 Number and 1 Special Character"
    static let allowFaceForPassword : String = "You need to allow face permission to see your password"
    static let allowFaceForUpdate : String = "You need to allow face permission to update account"
}
