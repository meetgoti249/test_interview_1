//
//  AppUtilities.swift
//  Interview
//
//  Created by Meet Goti on 10/08/24.
//

import Foundation
import UIKit

struct AppUtilities {
    static func openSetting() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
   static func randomStringWithLength (len : Int) -> NSString {
 
        let letters : NSString =  NSString(string: MatchCharacterConstant.capitalAlphabet + MatchCharacterConstant.smallAlphabet + MatchCharacterConstant.spacialCharacter + MatchCharacterConstant.number)

        let randomString : NSMutableString = NSMutableString(capacity: len)

        for _ in 0..<len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString
    }
}
