//
//  TypesOfMovies.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 03/02/2024.
//

import Foundation
import UIKit
import SDWebImage

class TypesOfMovies: UIViewController,UIScrollViewDelegate{
  
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sienceButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var dramaButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet weak var horrorButton: UIButton!
    @IBOutlet weak var comedyButton: UIButton!
    @IBOutlet weak var romanceButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    private var database : [results] = []
    var gener : Int = 27
    var totalPage : Int = 0
    let  url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=27")!
    private  var refhrea: UIRefreshControl{
             let ref = UIRefreshControl()
             ref.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
             return ref
      }
    var nbPage = 1
    private var transferData : String = ""
    private var idNB : Int = 0
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
        tableView.addSubview(refhrea)
        fetchingData()
        c.customiseBottomTypes(bottom: horrorButton)
        c.customiseBottomTypes(bottom: comedyButton)
        c.customiseBottomTypes(bottom: romanceButton)
        c.customiseBottomTypes(bottom: actionButton)
        c.customiseBottomTypes(bottom: sienceButton)
        c.customiseBottomTypes(bottom: familyButton)
        c.customiseBottomTypes(bottom: dramaButton)
        c.customiseBottomTypes(bottom: animationButton)
        horrorButton.backgroundColor = UIColor.white
        horrorButton.tintColor = UIColor.black
    }
    //MARK: - Button Option
    
    @IBAction func horrorBotton(_ sender: UIButton) {
        c.selectedColor(bottom1: horrorButton, bottom2: comedyButton, bottom3: romanceButton, bottom4: actionButton, bottom5: sienceButton, bottom6: familyButton, bottom7: dramaButton, bottom8: animationButton)
        c.selecteColor(sender: horrorButton)
        nbPage = 1
        gener = 27
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        c.selectedColor(bottom1: actionButton, bottom2: comedyButton, bottom3: romanceButton, bottom4: horrorButton, bottom5: sienceButton, bottom6: familyButton, bottom7: dramaButton, bottom8: animationButton)
        c.selecteColor(sender: actionButton)
        gener = 28
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func comedyButton(_ sender: UIButton) {
        c.selectedColor(bottom1: comedyButton, bottom2: horrorButton, bottom3: romanceButton, bottom4: actionButton, bottom5: sienceButton, bottom6: familyButton, bottom7: dramaButton, bottom8: animationButton)
        c.selecteColor(sender: comedyButton)
        gener = 35
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func romanceButton(_ sender: UIButton) {
        c.selectedColor(bottom1: romanceButton, bottom2: comedyButton, bottom3: horrorButton, bottom4: actionButton, bottom5: sienceButton, bottom6: familyButton, bottom7: dramaButton, bottom8: animationButton)
        c.selecteColor(sender: romanceButton)
        gener = 10749
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func animationButton(_ sender: UIButton) {
        c.selectedColor(bottom1: animationButton, bottom2: comedyButton, bottom3: romanceButton, bottom4: actionButton, bottom5: sienceButton, bottom6: familyButton, bottom7: dramaButton, bottom8: horrorButton)
        c.selecteColor(sender: animationButton)
        gener = 16
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func dramaButton(_ sender: UIButton) {
        c.selectedColor(bottom1: dramaButton, bottom2: comedyButton, bottom3: romanceButton, bottom4: actionButton, bottom5: sienceButton, bottom6: familyButton, bottom7: horrorButton, bottom8: animationButton)
        c.selecteColor(sender: dramaButton)
        gener = 18
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func familyButton(_ sender: UIButton) {
        c.selectedColor(bottom1: familyButton, bottom2: comedyButton, bottom3: romanceButton, bottom4: actionButton, bottom5: sienceButton, bottom6: horrorButton, bottom7: dramaButton, bottom8: animationButton)
        c.selecteColor(sender: familyButton)
        gener = 10751
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    
    @IBAction func sienceButton(_ sender: UIButton) {
        c.selectedColor(bottom1: sienceButton, bottom2: comedyButton, bottom3: romanceButton, bottom4: actionButton, bottom5: horrorButton, bottom6: familyButton, bottom7: dramaButton, bottom8: animationButton)
        c.selecteColor(sender: sienceButton)
        gener = 878
        nbPage = 1
        fetchingData()
        t.topscroll(tableView: tableView)
    }
    //MARK: - Calling API
    func fetchingData(){
       
        auth(with: url, token: api.t){(listDatapi: ListDataApi) in
            DispatchQueue.main.async {
                self.database = listDatapi.results
                self.totalPage = listDatapi.total_pages
                self.tableView.reloadData()
              
            }
        }
    }

//MARK: - API for TypesOfMovies
    func auth(with url: URL, token: String, completion: @escaping (ListDataApi) -> ()) {
      
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(nbPage)&sort_by=popularity.desc&with_genres=\(gener)")! as URL,
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
//MARK: - Pull Refresh
    
    @objc func handleRefresh(_ control: UIRefreshControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            control.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        transferData = database[indexPath.row].title
        idNB = database[indexPath.row].id
        performSegue(withIdentifier: "\(k.st)", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(k.st)"{
            if let destinationVC = segue.destination as? DetailsMovie{
                destinationVC.selectedDetails = transferData
                destinationVC.nbID = idNB
            }
        }

    }
}
