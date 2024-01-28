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
    

    @IBOutlet weak var warringLabel: UILabel!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    

    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var deleteAccount: UIButton!
    var newEmail:String = ""
    var newPassword:String = ""
    var userAccount: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        warringLabel.isHidden = true
        deleteAccount.tintColor = UIColor.red
        changePassword.tintColor = UIColor.white
        c.designTF(textField: newPasswordTF)
        c.designBottom(bottom: changePassword)
        c.designBottom(bottom: deleteAccount)
        userAccount = (Auth.auth().currentUser?.email)!
        emailLabel.text = ("  Account:\(userAccount)")
    }
    
    
        
    
  
    @IBAction func changePasswordButton(_ sender: UIButton) {
        newPassword = newPasswordTF.text!
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                self.warringLabel.isHidden = false
                self.warringLabel.text = error.localizedDescription
            }else{
                self.warringLabel.isHidden = false
                self.warringLabel.text = "Your password has been Changed "
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
