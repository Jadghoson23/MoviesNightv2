//
//  CastOfMovies.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 07/02/2024.
//

import Foundation
import UIKit
import SDWebImage
class CastOfMovies : UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var castID : Int = 0
    private var dataBase: [cast] = []
    let url = URL(string: "https://api.themoviedb.org/3/person//movie_credits?language=en-US")
    
    var movieName = ""
    var tmdbID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(castID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
        callingApiCast()
    }
    //MARK: - API of Selcted cast
    struct castData:Codable{
        let cast:[cast]
    }
    struct cast:Codable{
        let id:Int
        let title:String
        let poster_path:URL!
        let release_date:String
    }

    //MARK: - Calling Api & Func of API
    func callingApiCast(){
        auth(with: url!, token: api.t){(CastData: castData) in
            DispatchQueue.main.async {
                self.dataBase = CastData.cast
                self.tableView.reloadData()
                print(self.dataBase)
            }
        }
    }
    func auth(with url: URL, token: String, completion: @escaping (castData) -> ()) {
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/person/\(castID)/movie_credits?language=en-US")! as URL,
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
                    let result = try JSONDecoder().decode(castData.self, from: data)
                    completion(result.self)
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
    
 //MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataBase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(k.cCell)", for: indexPath) as! TableViewCell
     
        let imageURL = dataBase[indexPath.row].poster_path
        if imageURL == URL(string:"") {
            let image = URL(string:k.dmi)
            cell.imageOfMovies.download(from: image!)
        }else {
            let image = "https://image.tmdb.org/t/p/w500\(imageURL!)"
            cell.imageOfMovies.download(from: image)
        }
        cell.titleCell.text = dataBase[indexPath.row].title
        cell.relaseDate.text = dataBase[indexPath.row].release_date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    //MARK: - Segue to Details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieName = dataBase[indexPath.row].title
        tmdbID = dataBase[indexPath.row].id
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "\(k.scd)", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(k.scd)"{
            if let destinationVC = segue.destination as? DetailsMovie{
                destinationVC.selectedDetails = movieName
                destinationVC.nbID = tmdbID
            }
        }
    }
    
}

