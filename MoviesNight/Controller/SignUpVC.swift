//
//  SignUpVC.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 24/12/2023.
//

import Foundation
import UIKit
import Firebase
class SignUpVC: UIViewController {
    
    var welcomeVC = WelcomeAppVC()
    
    @IBOutlet weak var warringLabel: UILabel!
    
    @IBOutlet weak var signUpBottom: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c.designBottom(bottom: signUpBottom)
        c.designTF(textField: emailTF)
        c.designTF(textField: passwordTF)
        warringLabel.isHidden = true
        
    }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if let email = emailTF.text,
           let password = passwordTF.text{
            Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
                if let e = error{
                    self.warringLabel.isHidden = false
                    self.warringLabel.text = e.localizedDescription
                }else{
                    self.performSegue(withIdentifier: "\(k.signToApp)", sender: self)
                }
            }
        }
       
        
        
    }
}
