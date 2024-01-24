//
//  SearchList.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 21/12/2023.
//

import Foundation
import UIKit
import SDWebImage
class SearchList: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var userSearch: String?
    var selectedData: [results] = []
    var specialData = ""
    var idNB: Int = 0
    var page: Int = 1
    var totalPages: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = URL(string:"https://api.themoviedb.org/3/search/movie?query=\(userSearch!)&include_adult=false&language=en-US&page=\(page)")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
      
            auth(with: url!, token: api.t){(listDatapi: ListDataApi) in
                DispatchQueue.main.async {
                    self.selectedData = listDatapi.results
                    self.totalPages = listDatapi.total_pages
                    self.tableView.reloadData()
                }
              
            
        }
        
}
    
    //MARK: API
    
    func auth(with url: URL, token: String, completion: @escaping (ListDataApi) -> ()) {
      
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/search/movie?query=\(userSearch!)&include_adult=false&language=en-US&page=1")! as URL,
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
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(k.cCell)", for: indexPath) as! TableViewCell
        let imageURL = selectedData[indexPath.row].poster_path
        let image = "https://image.tmdb.org/t/p/w500\(imageURL)"
        cell.titleCell.text = selectedData[indexPath.row].title
        cell.relaseDate.text = selectedData[indexPath.row].release_date
        cell.imageOfMovies.download(from: image)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        specialData = selectedData[indexPath.row].title
        idNB = selectedData[indexPath.row].id
        print(idNB)
        performSegue(withIdentifier: "\(k.gtd)", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(k.gtd)"{
            if let destinationVC = segue.destination as? DetailsMovie{
                destinationVC.selectedDetails = specialData
                destinationVC.nbID = idNB
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var url = URL(string:"https://api.themoviedb.org/3/search/movie?query=\(userSearch!)&include_adult=false&language=en-US&page=\(page)")

        if page != totalPages{
            if indexPath.row == selectedData.count - 1{
                page = (page + 1)
                print(totalPages)
                auth(with: url!, token: api.t){(listDatapi: ListDataApi) in
                    DispatchQueue.main.async {
                        self.selectedData.append(contentsOf: listDatapi.results)
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            return
        }
    }
}



