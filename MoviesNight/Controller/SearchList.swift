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
    @IBOutlet weak var warringLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var userSearch: String?
    var selectedData: [Search] = []
    var specialData = ""
    var id = ""
    var nbPages: Int = 1
    var totalPages:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        warringLabel.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "\(k.nib)", bundle: nil), forCellReuseIdentifier: "\(k.cCell)")
       
        
        
        ApiSearching{ data in
            self.selectedData = data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    //MARK: API
    func ApiSearching(completion: @escaping([Search]) -> ()){
       
        let link = "https://www.omdbapi.com/?s=\(userSearch!)&page=\(nbPages)&apikey=\(k.apikey)"
        print(link)
        let url = URL(string: link)
        guard url != nil else{
            print("error in api")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){ data, response, error in

            if error == nil , data != nil{
                let decoder = JSONDecoder()
              
                do{
                    let result = try decoder.decode(SearchListData.self, from: data!)
                    completion(result.Search)
                    
                }catch{
                    print("error to decoder")
                    
                }
            }
        }
        dataTask.resume()
    }
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(k.cCell)", for: indexPath) as! TableViewCell
        let imageURL = selectedData[indexPath.row].Poster
        cell.titleCell.text = selectedData[indexPath.row].Title
        cell.relaseDate.text = selectedData[indexPath.row].Year
        cell.imageOfMovies.download(from: imageURL)
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        specialData = selectedData[indexPath.row].Title
        id = selectedData[indexPath.row].imdbID
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "\(k.gtd)", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "\(k.gtd)"{
            if let destinationVC = segue.destination as? DetailsMovie{
                destinationVC.selectedDetails = specialData
                destinationVC.imdbID = id
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    //MARK: Pagination Search List
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if nbPages != totalPages{
            if indexPath.row == selectedData.count - 1{
                nbPages = (nbPages + 1)
                if nbPages != totalPages{
                ApiSearching{ data in
                    self.selectedData = data
                    DispatchQueue.main.async {
                        self.selectedData.append(contentsOf: data)
                        self.tableView.reloadData()
                    }
            }
                }
            }
        }else{
            return
        }
   
    }
}



