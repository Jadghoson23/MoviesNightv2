//
//  WishList.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 27/01/2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
class WishList:  UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    let database = Firestore.firestore()
    var firebase:[String:Any]?
    var test : [Any] = []
    var apidata = ""
    var whishdata : WishListAPI?
    var data : [WishListAPI] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RUN")
        tableView.dataSource = self
        tableView.delegate = self
       
       loadingAccount()
        tableView.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
   
    }
    
    
    func loadingAccount(){
        let docRef  = Auth.auth().currentUser?.email!
     
        database.collection("database").document("\(docRef!)").getDocument {(document, error) in
            if error == nil {
                if document != nil && document!.exists {
                    self.firebase = document!.data()
                    
                    let na = Array(self.firebase!.values)
                    self.test = na
                    self.wishListData()
                }
            }
            
        }
    }
  //MARK: - API WishList
    func wishListData(){
        for v in self.test {
            apidata = v as! String
       let  url = URL(string: "https://api.themoviedb.org/3/movie/\(apidata)?language=en-US")!
       
            auth(with: url, token: api.t){(wishResult: WishListAPI) in
                DispatchQueue.main.async {
                    self.whishdata = wishResult
                    self.data.append(contentsOf: [wishResult])
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print(self.data)
            self.tableView.reloadData()
        }
    }
  
    func auth(with url: URL, token: String, completion: @escaping (WishListAPI) -> ()) {
  
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(apidata)?language=en-US")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
      
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = api.h
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(WishListAPI.self, from: data)
                    completion(result.self)
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
 }
extension WishList : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(k.cCell)", for: indexPath) as! TableViewCell
        let imageURL = data[indexPath.row].poster_path
        let image = "https://image.tmdb.org/t/p/w500\(imageURL)"
        cell.titleCell.text = data[indexPath.row].original_title
        cell.imageOfMovies.download(from: image)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row].id)
    }
}

