//
//  SMSCodeVC.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 10/03/2024.
//

import UIKit

class SMSCodeVC: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var smsVerfication: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        let code = "111311" // Replace with the desired phone number

        AuthManger.shared.verifyCode(smsCode: code) { success in
            guard success else{return
                print("Error in Guard")
            }
            print("Done")
        
        }
    }
}

