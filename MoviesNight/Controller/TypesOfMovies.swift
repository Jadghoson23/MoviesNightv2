//
//  TypesOfMovies.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 03/02/2024.
//

import Foundation
import UIKit
import SDWebImage

class TypesOfMovies: UIViewController{
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var horrorButton: UIButton!
    @IBOutlet weak var comedyButton: UIButton!
    @IBOutlet weak var romanceButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    private var database : [results] = []
    var totalPage : Int = 0
    let  url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=27")!
    var nbPage = 1
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
        print("Run")
        fetchingData()
        c.customiseBottomTypes(bottom: horrorButton)
        c.customiseBottomTypes(bottom: comedyButton)
        c.customiseBottomTypes(bottom: romanceButton)
        c.customiseBottomTypes(bottom: actionButton)
        horrorButton.backgroundColor = UIColor.white
        
        
        
        
        
    }
    func fetchingData(){
       
        auth(with: url, token: api.t){(listDatapi: ListDataApi) in
            DispatchQueue.main.async {
                self.database = listDatapi.results
                self.totalPage = listDatapi.total_pages
                self.tableView.reloadData()
                print("Hello World")
            }
        }
    }

//MARK: - API for TypesOfMovies
    func auth(with url: URL, token: String, completion: @escaping (ListDataApi) -> ()) {
      
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(nbPage)&sort_by=popularity.desc&with_genres=27")! as URL,
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
                    let result = try JSONDecoder().decode(ListDataApi.self, from: data)
                    completion(result.self)
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
  //MARK: - Button Option
    
    
    
    
    
}
//MARK: - TableView Methods

extension TypesOfMovies: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(k.cCell)", for: indexPath) as! TableViewCell
        let imageURL = database[indexPath.row].poster_path
        let image = "https://image.tmdb.org/t/p/w500\(imageURL)"
        cell.titleCell.text = database[indexPath.row].title
        cell.relaseDate.text = database[indexPath.row].release_date
        cell.imageOfMovies.download(from: image)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
 //MARK: - Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if nbPage != totalPage{
            if indexPath.row == database.count - 1{
                nbPage = (nbPage + 1)
                auth(with: url, token: api.t){(listDatapi: ListDataApi) in
                    DispatchQueue.main.async {
                        self.database.append(contentsOf: listDatapi.results)
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            return
        }
    }
    
}
