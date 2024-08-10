//
//  AuthenticatorManager.swift
//  Interview
//
//  Created by Meet Goti on 10/08/24.
//

import Foundation
import LocalAuthentication

class AuthenticatorManager : ObservableObject {
    
    init() {
    }
    @Published var isAuthenticate : Bool = false
    @Published var showFacePermissionAlert:Bool = false
    
    //MARK: Face Authenticate
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    self.isAuthenticate = success
                }
            }
        } else {
            self.showFacePermissionAlert = true
        }
    }
}
