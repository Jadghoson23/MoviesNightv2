//
//  TabBarVC.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 17/01/2024.
//

import Foundation
import UIKit
import Firebase
class TabBarVC:UITabBarController{
    
    
    
    
    
    @IBAction func signOutButton(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }catch _ as NSError{
            print("Error log out")
        }
        
        
        
    }
}
