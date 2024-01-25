//
//  DetailsMovie.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 21/12/2023.
//

import Foundation
import UIKit
import SDWebImage
import YoutubePlayer_in_WKWebView
class DetailsMovie: UIViewController, WKYTPlayerViewDelegate {
    var selectedDetails = ""
    var nbID: Int = 0
    var newData: DetailsApi?
    var trailerData: [results] = []
    var trailerID = ""
    var imdbID : String?
    var convertData: [movie_results] = []
    //MARK: Label List
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBOutlet weak var trailerView: WKYTPlayerView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var generLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var awardLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerView.delegate = self
        uploadDataAndFetching()
        if imdbID != nil {
            convertAPI()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.fetchingTrailer()
        }
        
       
        //MARK: Trailer Display
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.loadingLabel.isHidden = true
            self.trailerView.load(withVideoId: "\(self.trailerID)")
        }
        
    }
    func fetchingTrailer(){
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(nbID)/videos?language=en-US")
     
        auth(with: url!, token: api.t){(apiTrailer: [results]) in
            DispatchQueue.main.async {
                self.trailerID = apiTrailer[0].key
                print(apiTrailer.count)
            }
        }
    }
    func uploadDataAndFetching(){
        ApiFectchingData{ data in
            self.newData = data
            DispatchQueue.main.sync {
                //MARK: Display the Data to Labels
                
                self.releaseDate.text = ("Release Date: \(self.newData!.Released)")
                self.runTime.text = ("Runtime: \(self.newData!.Runtime)")
                self.generLabel.text = ("Genre: \(self.newData!.Genre)")
                self.directorLabel.text = ("Director: \(self.newData!.Director)")
                self.writerLabel.text = ("Writer: \(self.newData!.Writer)")
                self.languageLabel.text = ("Language: \(self.newData!.Language)")
                self.countryLabel.text = ("Country: \(self.newData!.Country)")
                self.awardLabel.text = ("Award: \(self.newData!.Awards)")
                self.descriptionLabel.text = ("Description: \(self.newData!.Plot)")
                self.imageMovie.download(from: self.newData!.Poster)
                self.navigationTitle.title = self.newData?.Title
                
            }
        }
    }
    //MARK: -API omdapi(Information of Movie)
    func ApiFectchingData(completion: @escaping(DetailsApi) -> ()){
        let linkapi = "https://www.omdbapi.com/?t=\(selectedDetails)&apikey=\(k.apikey)&plot=full"
        let url = URL(string: linkapi)
        guard url != nil else{
            print("error api link")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){ data, response ,error in
            if error == nil , data != nil {
                let decoder = JSONDecoder()
                
                do{
                    let result = try decoder.decode(DetailsApi.self, from: data!)
                    completion(result.self)
                }catch{
                    print("error Decoder")
                }
            }
        }
        dataTask.resume()
    }
    
    //MARK: -API Trailer
    struct ApiTrailer:Codable{
        let results: [results]
    }
    struct results:Codable{
        let key:String
    }
    
    //MARK: -Fetcing API Trailer
    func auth(with url: URL, token: String, completion: @escaping ([results]) -> ()) {
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(nbID)/videos?language=en-US")! as URL,
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
                    let result = try JSONDecoder().decode(ApiTrailer.self, from: data)
                    completion(result.results.self)
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    //MARK: - Convert API (IMDB to TMDB)
    
    func convertAPI(){
        let url = URL(string: "https://api.themoviedb.org/3/find/\(imdbID!))?external_source=imdb_id")
        authID(with: url!, token: api.t){(convertAPI: [movie_results]) in
            
            DispatchQueue.main.async {
                self.convertData = convertAPI
                guard (self.convertData.count == 1) else {return}
                    self.nbID = self.convertData[0].id
            }
        }
        
        func authID(with url: URL, token: String, completion: @escaping ([movie_results]) -> ()) {
            
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/find/\(imdbID!)?external_source=imdb_id")! as URL,
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
                        let result = try JSONDecoder().decode(ConvertAPI.self, from: data)
                        completion(result.movie_results.self)
                      
                    } catch let error {
                        print(error)
                    }
                }
            })
            dataTask.resume()
        }
    }
}
