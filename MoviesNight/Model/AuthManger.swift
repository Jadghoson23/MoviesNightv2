//
//  AuthManger.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 09/03/2024.
//

import Foundation
import FirebaseAuth

class AuthManger {//This Call of Controlle the Authentication
    static let shared = AuthManger()
    private let auth = Auth.auth()
    private var verficationId: String?
    
   
    public func startAuth(phoneNumber:String, completion: @escaping(Bool) -> Void){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verficationId, error in
            guard let verficationId = verficationId, error == nil else{
                completion(false)
                return
            }
            Auth.auth().languageCode = "en";
            self?.verficationId = verficationId
            print(verficationId)
            print("Done")
            completion(true)
        }
    }
    public func verifyCode(smsCode:String,completion: @escaping(Bool) -> Void){
        guard let verficationId = verficationId else{
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verficationId,
            verificationCode: smsCode)
        
        auth.signIn(with: credential) { result, error in
            guard  result != nil , error == nil else{
                completion(false)
                return
            }
            completion(true)
        }
    }
}
