//
//  PasswordEncrption.swift
//  Interview
//
//  Created by Meet Goti on 10/08/24.
//

import Foundation
import SwiftyRSA
import RealmSwift

class PasswordEncryption  {
    var sourceString:String
    var realm : Realm
    
    init(sourceString: String) {
        self.sourceString = sourceString
        
        realm = try! Realm()
        self.setData()
    }
    
    func setData() {
        guard let result = realm.object(ofType: EncryptionDataModel.self,forPrimaryKey: "1") else {
            do {
                let keyPair = try SwiftyRSA.generateRSAKeyPair(sizeInBits: 2048)
                data.publicKey = try keyPair.publicKey.pemString()
                data.privateKey = try keyPair.privateKey.pemString()
            } catch  {
            }
            
            realm.beginWrite()
            realm.add(data)
            try! realm.commitWrite()
            return
        }
        self.data = result
        
    }
    private var data:EncryptionDataModel = EncryptionDataModel()
//    
     func encryptPassword()  -> String? {
        do {
            let message = try ClearMessage(string: sourceString, using: .utf8)
            let encryptedString = try message.encrypted(with: PublicKey(pemEncoded: data.publicKey), padding: .PKCS1)
            return encryptedString.base64String
        } catch  {
            return nil
        }
    }
    
    func decryptPassword() -> String? {
        do {
        let encrypted = try EncryptedMessage(base64Encoded: sourceString)
            let clear = try encrypted.decrypted(with: PrivateKey(pemEncoded: data.privateKey), padding: .PKCS1).string(encoding: .utf8)
            return clear
        } catch  {
            return nil
        }
    }
}

class EncryptionDataModel:Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: String = "1"
    @Persisted var publicKey:String
    @Persisted var privateKey:String
    
    func setPrivatePublicKey(publicKey:String,privateKey:String) {
        
    }
}
