//
//  Constant.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 25/12/2023.
//

import Foundation
import UIKit

struct k {
    static let apikey = "e665d872"
    static let logToApp = "loginToApp"
    static let signToApp = "signupToApp"
    static let sl = "searchList"
    static let sd = "ListToDetails"
    static let cCell = "MoviesCell"
    static let gtd = "goToDetails"
    static let nib = "TableViewCell"
    static let swd = "wishToDetails"
}
struct c{
    static func designTF(textField: UITextField){
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        
    }
    static func designBottom(bottom:UIButton){
            bottom.layer.cornerRadius = bottom.frame.height / 2
            bottom.layer.masksToBounds = true
        }
    static func customiseBottom(bottom: UIButton){
        bottom.layer.cornerRadius = bottom.frame.height / 2
        bottom.layer.masksToBounds = true
        bottom.layer.borderWidth = 2.0
        bottom.layer.borderColor = UIColor.red.cgColor
        bottom.tintColor = UIColor.red
    }
}
struct api {
    static let h = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MzM3OWRiNWE4NjlhMzI2MjQyM2UxOWQ4ZGE0NmUyYiIsInN1YiI6IjY1ODQ3Yzc0ZDU1Njk3MTc0NTUyNzg1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.24tb1PdMV0UV59bajVFOcmI8wbes2OdE_ZKf59sdL1Q"
    ]
    static let t = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MzM3OWRiNWE4NjlhMzI2MjQyM2UxOWQ4ZGE0NmUyYiIsInN1YiI6IjY1ODQ3Yzc0ZDU1Njk3MTc0NTUyNzg1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.24tb1PdMV0UV59bajVFOcmI8wbes2OdE_ZKf59sdL1Q"
}
struct tester{
    let data : [test]
}
struct test {
    let key : Int
}
