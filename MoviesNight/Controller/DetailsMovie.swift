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
import FirebaseFirestore
import Firebase
class DetailsMovie: UIViewController, WKYTPlayerViewDelegate {
    
    var selectedDetails = ""
    var nbID: Int = 0
    var newData: DetailsApi?
    var trailerData: [results] = []
    var trailerID = ""
    var imdbID : String?
    var convertData: [movie_results] = []
    var wish: Bool = false
    var wishButton = UIImage(systemName: "star")
    var wishCheckButton = ""
    var type = "t"
    var castData : [cast] = []
    var castID : Int = 0
    //MARK: Label List
   
    
    @IBOutlet weak var collectionView: UICollectionView!
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
        if imdbID != nil {
            convertAPI()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.fetchingCastData()
                self.collectionView.reloadData()
            }
        }else{
            fetchingCastData()
        }
        trailerView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        if wish == true{
            wishButton = UIImage(systemName: "star.fill")
        }else{
            wishButton = UIImage(systemName: "star")
        }
        let button = UIBarButtonItem(image: wishButton, style: .plain, target: self, action: #selector(action))
            navigationItem.rightBarButtonItem = button
        if Auth.auth().currentUser?.email == nil{
            button.isEnabled = false
        }
        uploadDataAndFetching()
        
        
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.fetchingTrailer()
            self.collectionView.reloadData()
        }
        //MARK: Trailer Display
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.loadingLabel.isHidden = true
            self.trailerView.load(withVideoId: "\(self.trailerID)")
        }
    }
    @objc func action (){
        wish.toggle()
        
            if wish == false{
                wishButton = UIImage(systemName: "star")
                wishdeleted()
                viewDidLoad()
            }else{
                wishButton = UIImage(systemName: "star.fill")
                wishSelcted()
                viewDidLoad()
        }
    }
   func wishSelcted() {
        let docRef  = Auth.auth().currentUser?.email!
        let database = Firestore.firestore()
         database.collection("database").document("\(docRef!)").setData(["\(nbID)":"\(nbID)"], merge: true)

    }
    func wishdeleted(){
        let docRef  = Auth.auth().currentUser?.email!
        let database = Firestore.firestore()
        database.collection("database").document("\(docRef!)").updateData(["\(nbID)":FieldValue.delete()])
    }
    //MARK: - Calling API Trailer
    func fetchingTrailer(){
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(nbID)/videos?language=en-US")
        
        auth(with: url!, token: api.t){(apiTrailer: [results]) in
            DispatchQueue.main.async {
                guard apiTrailer.count >= 1 else {return}
                self.trailerID = apiTrailer[0].key
                print(apiTrailer.count)
            }
        }
    }
        //MARK: - Calling API Cast
        func fetchingCastData(){
            let url = URL(string:"https://api.themoviedb.org/3/movie/\(nbID)/credits?language=en-US")
            auth(with: url!, token: api.t){(castingData: CastApi) in
                DispatchQueue.main.async {
                    self.castData = castingData.cast
                }
            }
        
    }
    //MARK: - Calling API (OMD)
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
        let linkapi = "https://www.omdbapi.com/?\(type)=\(selectedDetails)&apikey=\(k.apikey)&plot=short"
        print(linkapi)
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
    //MARK: - Convert API (OMD to TMDB)
    
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
//MARK: - Extension Collection & API Cast

extension DetailsMovie: UICollectionViewDelegate,UICollectionViewDataSource{
    //MARK: - collection Methods
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            castData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let imageURL = castData[indexPath.row].profile_path
 
        if imageURL == URL(string:"") {
            let image = URL(string:k.di)
            cell.imageCell.download(from: image!)
        }else {
            let image = "https://image.tmdb.org/t/p/w500\(imageURL!)"
            cell.imageCell.download(from: image)
        }
        cell.charachterName.text = castData[indexPath.row].character
        cell.castName.text = castData[indexPath.row].original_name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        castID = castData[indexPath.row].id
        performSegue(withIdentifier: "CastToMovies", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CastToMovies"{
            if let destinationVC = segue.destination as? CastOfMovies{
                destinationVC.castID = castID
            }
        }
    }
//MARK: - API Casting
    func auth(with url: URL, token: String, completion: @escaping (CastApi) -> ()) {
      
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(nbID)/credits?language=en-US")! as URL,
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
                    let result = try JSONDecoder().decode(CastApi.self, from: data)
                    completion(result.self)
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }

}
//MARK: - API of Cast
struct CastApi: Codable{
    let cast:[cast]
}
struct cast: Codable{
    let id :Int
    let original_name :String
    let character:String
    let profile_path:URL!
}
