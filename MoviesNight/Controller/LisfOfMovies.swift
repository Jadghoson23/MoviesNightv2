//
//  LisfOfMovies.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 30/12/2023.
import Foundation
import UIKit
import SDWebImage

class ListOfMovies: UIViewController,UIScrollViewDelegate{
    

    @IBOutlet weak var topRattingButton: UIButton!
    
    @IBOutlet weak var popularButton: UIButton!
    
    @IBOutlet weak var nowPlaying: UIButton!
    
    @IBOutlet weak var soonPlaying: UIButton!
    
    @IBOutlet weak var listTV: UITableView!
 
    var mode = "top_rated"
    var database : [results] = []
    var nbPages = 1
    var idNB: Int = 0
    var refresh: Bool = false
    let  url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1)")!
  
    var transferData: String = ""
    var TotalPages:Int = 0
  private  var refhrea: UIRefreshControl{
           let ref = UIRefreshControl()
           ref.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
           return ref
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        c.customiseBottom(bottom: topRattingButton)
        c.customiseBottom(bottom: popularButton)
        c.customiseBottom(bottom: nowPlaying)
        c.customiseBottom(bottom: soonPlaying)
        topRattingButton.tintColor = UIColor.white
        listTV.dataSource = self
        listTV.delegate = self
        listTV.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
        

        fetchingData()
        listTV.addSubview(refhrea)
       
       
    }
    //MARK: - Pull Refresh
    @objc func handleRefresh(_ control: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            control.endRefreshing()
            self.listTV.reloadData()
        }
      
    }
    
    
    
    //MARK: - Button Options
    @IBAction func topRated(_ sender: UIButton) {
        mode = "top_rated"
        nbPages = 1
        topScroll()
        topRattingButton.tintColor = UIColor.white
        nowPlaying.tintColor = UIColor.red
        popularButton.tintColor = UIColor.red
        soonPlaying.tintColor = UIColor.red
        fetchingData()
    }
    @IBAction func nowPlaying(_ sender: UIButton) {
        mode = "now_playing"
        nbPages = 1
        nowPlaying.tintColor = UIColor.white
        topRattingButton.tintColor = UIColor.red
        popularButton.tintColor = UIColor.red
        soonPlaying.tintColor = UIColor.red
        fetchingData()
    }
    @IBAction func popularMovies(_ sender: UIButton) {
        mode = "popular"
        nbPages = 1
        topScroll()
        nowPlaying.tintColor = UIColor.red
        topRattingButton.tintColor = UIColor.red
        popularButton.tintColor = UIColor.white
        soonPlaying.tintColor = UIColor.red
        fetchingData()
    }
    
    @IBAction func upComming(_ sender: UIButton) {
        mode = "upcoming"
        nbPages = 1
        topScroll()
        nowPlaying.tintColor = UIColor.red
        topRattingButton.tintColor = UIColor.red
        popularButton.tintColor = UIColor.red
        soonPlaying.tintColor = UIColor.white
        fetchingData()
    }
    //MARK: - Calling API (TMDB)
    func fetchingData(){
        auth(with: url, token: api.t){(listDatapi: ListDataApi) in
            DispatchQueue.main.async {
                self.database = listDatapi.results
                self.TotalPages = listDatapi.total_pages
                self.listTV.reloadData()
            }
        }
    }
    
    //MARK: - Api Fetching (TMDB)
    func auth(with url: URL, token: String, completion: @escaping (ListDataApi) -> ()) {
      
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(mode)?language=en-US&page=\(nbPages)")! as URL,
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
}
//MARK: - Table View Delegates Methods
extension ListOfMovies: UITableViewDataSource, UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(k.cCell)", for: indexPath) as! TableViewCell
        let imageURL = database[indexPath.row].poster_path
        let image = "https://image.tmdb.org/t/p/w500\(imageURL)"
        cell.titleCell.text = database[indexPath.row].title
        cell.imageOfMovies.download(from: image)
        cell.relaseDate.text = database[indexPath.row].release_date
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transferData = database[indexPath.row].title
        idNB = database[indexPath.row].id
        performSegue(withIdentifier: "\(k.sd)", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(k.sd)"{
            if let destinationVC = segue.destination as? DetailsMovie{
                destinationVC.selectedDetails = transferData
                destinationVC.nbID = idNB
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func topScroll(){
        let indexPath = IndexPath(row: 0, section: 0 )
        listTV.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    //MARK: - Pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if nbPages != TotalPages{
            if indexPath.row == database.count - 1{
                nbPages = (nbPages + 1)
                auth(with: url, token: api.t){(listDatapi: ListDataApi) in
                    DispatchQueue.main.async {
                        self.database.append(contentsOf: listDatapi.results)
                        self.listTV.reloadData()
                    }
                }
            }
        }else{
            return
        }
   
    }
   
}
