//
//  PhoneNumverVerfication.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 08/03/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
class PhoneNumberVerfication: UIViewController,UITextFieldDelegate{
  
    
  
    
    
    var phoneNumber: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello World")
        
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        let phoneNumber = "+9613054995" // Replace with the desired phone number

        AuthManger.shared.startAuth(phoneNumber: phoneNumber) {  success in
            guard success else{return
                print("Error in Guard")
            }
        
        }
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "NumberToSMS", sender: self)
        }
    
        
    }
}
