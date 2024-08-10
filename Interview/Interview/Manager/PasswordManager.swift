//
//  PasswordManager.swift
//  Interview
//
//  Created by Meet Goti on 09/08/24.
//

import Foundation
import RealmSwift

//MARK: Manage the password
class PasswordManager: ObservableObject {
    
    var realm : Realm
    static let shared : PasswordManager = PasswordManager()
    
    private init() {
        /// Initialize realm object
        realm = try! Realm()
        
        
        self.getData()
    }
    
    @Published private(set) var listOfPassword : [PasswordsInfo] = []
    @Published var validationMessage :String = ""

    /// Validate the record
    func validateData(_ data:PasswordsInfo) -> Bool {
        let constant = data.validate()
        self.validationMessage = constant
        return !constant.isEmpty
    }
    
    ///Add new Password
    func addData(_ data : PasswordsInfo) {
        let model = data.setPasswordModel()
        self.listOfPassword.append(PasswordsInfo.makePassword(model))
        
        // Insert new record in the local database
        realm.beginWrite()
        realm.add(model)
        try! realm.commitWrite()
    }
    
    /// Edit password
    func editData(_ data : PasswordsInfo) {
        if let index = self.listOfPassword.firstIndex(of: data) {
            self.listOfPassword[index].name = data.name
            self.listOfPassword[index].userNameEmail = data.userNameEmail
            self.listOfPassword[index].password = data.password
            
            /// Edit record in the local database
            let result = realm.object(ofType: PasswordDataModel.self, forPrimaryKey: data.id)
            realm.beginWrite()
            result?.updateData(data)
            try! realm.commitWrite()
        }
    }
    
    /// Remove password
    func removeData(_ data : PasswordsInfo) {
        if let index = self.listOfPassword.firstIndex(of: data) {
            self.listOfPassword.remove(at: index)
            
            /// Delete record from local database
            realm.beginWrite()
            if let result = realm.object(ofType: PasswordDataModel.self, forPrimaryKey: data.id) {
                realm.delete(result)
            }
            try! realm.commitWrite()
        }
    }
    
    /// Get data from local database
    func getData() {
        print("File URL :- \(realm.configuration.fileURL?.absoluteString)")
        let results = realm.objects(PasswordDataModel.self)
        self.listOfPassword = results.map({PasswordsInfo.makePassword($0)})
    }
    
  
}

