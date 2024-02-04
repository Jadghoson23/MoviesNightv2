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
    
        override func viewDidLoad() {
        super.viewDidLoad()
        c.designBottom(bottom: loginButton)
        c.designBottom(bottom: signupButton)
        
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
