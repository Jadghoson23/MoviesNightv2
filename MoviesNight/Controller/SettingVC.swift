//
//  SettingVC.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 26/01/2024.
//

import Foundation
import Firebase
import UIKit
import IQKeyboardManagerSwift
class SettingVC: UIViewController{
    
    @IBOutlet weak var newEmailTF: UITextField!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var changeEmail: UIButton!
    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var deleteAccount: UIButton!
    var newEmail:String = ""
    var newPassword:String = ""
    var userAccount: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        deleteAccount.tintColor = UIColor.red
        c.designBottom(bottom: changeEmail)
        c.designBottom(bottom: changePassword)
        c.designBottom(bottom: deleteAccount)
        userAccount = (Auth.auth().currentUser?.email)!
        emailLabel.text = ("  Email:\(userAccount)")
    }
    
    
    
    @IBAction func changeEmailButton(_ sender: UIButton) {
        newEmail = newEmailTF.text!
        Auth.auth().currentUser?.sendEmailVerification { [self] error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                Auth.auth().currentUser?.updateEmail(to: newEmail) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
           
        }
        
    }
    
    
  
    @IBAction func changePasswordButton(_ sender: UIButton) {
        newPassword = newPasswordTF.text!
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func deleteUserAccount(_ sender: UIButton) {
        
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
              print(error.localizedDescription)
          } else {
              do{
                  try Auth.auth().signOut()
                  self.navigationController?.popViewController(animated: true)
              }catch _ as NSError{
                  print("Error log out")
              }
          }
        }
        
    }
    
}
