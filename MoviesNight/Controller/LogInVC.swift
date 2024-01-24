//
//  LogInVC.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 24/12/2023.
//

import Foundation
import UIKit
import Firebase
class LogInVC: UIViewController{
    
    
    @IBOutlet weak var logInBottom: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var warringLabel: UILabel!
    var welcomeVC = WelcomeAppVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        c.designBottom(bottom: logInBottom)
        c.designTF(textField: emailTF)
        c.designTF(textField: PasswordTF)
        warringLabel.isHidden = true
    }
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        if let emailUser = emailTF.text, let passwordUser = PasswordTF.text{
            Auth.auth().signIn(withEmail: emailUser, password: passwordUser){[weak self] authResult,
                error in
                if let e = error{
                    self?.warringLabel.isHidden = false
                    self?.warringLabel.text = e.localizedDescription
                    print(e.localizedDescription)
                }else{
                    self!.performSegue(withIdentifier: "\(k.logToApp)", sender: self)
                }
                
            }
        }
        
    }
    
}
