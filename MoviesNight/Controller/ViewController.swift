//
//  ViewController.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 21/12/2023.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    
    var searchName: String? 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        c.designTF(textField: searchTF)
    }
  

    @IBAction func tst(_ sender: UITextField) {
        if searchTF.text == "" {
            print("its nill")
            return
        }else{
            searchName = searchTF.text!
            performSegue(withIdentifier: "\(k.sl)" , sender: self)
            searchTF.text! = ""
        }
        
    }
    

    @IBAction func searchButton(_ sender: UIButton) {
        if searchTF.text != ""{
            searchName = searchTF.text!
            performSegue(withIdentifier: "\(k.sl)" , sender: self)
            searchTF.text! = ""
        }else{
            print("nil")
            return
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(k.sl)" {
            if let destinationVC = segue.destination as? SearchList{
                destinationVC.userSearch = searchName
            }
        }
    }
}
