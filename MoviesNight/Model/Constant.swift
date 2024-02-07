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
    static let st = "TypeToDetails"
    static let scd = "CastToDetails"
    static let cCell = "MoviesCell"
    static let gtd = "goToDetails"
    static let nib = "TableViewCell"
    static let swd = "wishToDetails"
    static let di = "https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg?size=338&ext=jpg&ga=GA1.1.87170709.1707264000&semt=ais"
    static let dmi = "https://eagle-sensors.com/wp-content/uploads/unavailable-image.jpg"
    
}
struct t {
    static func topscroll(tableView: UITableView){
        let indexPath = IndexPath(row: 0, section: 0 )
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
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
    static func customiseBottomTypes(bottom:UIButton){
        bottom.layer.cornerRadius = bottom.frame.height / 2
        bottom.layer.masksToBounds = true
        bottom.layer.borderWidth = 2.0
        bottom.layer.borderColor = UIColor.red.cgColor
        bottom.tintColor = UIColor.white
    }
    static func selecteColor(sender:UIButton){
        sender.backgroundColor = UIColor.white
        sender.tintColor = UIColor.black
        
    }
    static func selectedColor(bottom1:UIButton,bottom2:UIButton,bottom3:UIButton,bottom4:UIButton,bottom5:UIButton,bottom6:UIButton,bottom7:UIButton,bottom8:UIButton){
        bottom1.backgroundColor = UIColor.white
        bottom1.tintColor = UIColor.black
        bottom2.backgroundColor = UIColor.red
        bottom2.tintColor = UIColor.white
        bottom3.backgroundColor = UIColor.red
        bottom3.tintColor = UIColor.white
        bottom4.backgroundColor = UIColor.red
        bottom4.tintColor = UIColor.white
        bottom5.backgroundColor = UIColor.red
        bottom5.tintColor = UIColor.white
        bottom6.backgroundColor = UIColor.red
        bottom6.tintColor = UIColor.white
        bottom7.backgroundColor = UIColor.red
        bottom7.tintColor = UIColor.white
        bottom8.backgroundColor = UIColor.red
        bottom8.tintColor = UIColor.white
        
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
