//
//  WelcomeAppVC.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 25/12/2023.
//
//Hello World
import Foundation
import UIKit

class WelcomeAppVC:UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBOutlet weak var movieAnimation: UILabel!
    
    var testing = 1023
    override func viewDidLoad() {
        super.viewDidLoad()
        c.designBottom(bottom: loginButton)
        c.designBottom(bottom: signupButton)
        //loginButton.frame = CGRect(x: 0, y:0, width: 200, height: 50)
        
        movieAnimation.text = ""
        var charIndex = 0.0
        let titleText = "MoviesNight"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.movieAnimation.text?.append(letter)
            }
            charIndex += 1
        }
        
    }
    
  
    
}
