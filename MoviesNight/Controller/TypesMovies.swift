//
//  TypesMovies.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 06/01/2024.
//

import Foundation
import UIKit

class TypesMovies: UIViewController{
    
    
    @IBOutlet weak var typesTV: UITableView!
    var test = [1, 2, 3,4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typesTV.dataSource = self
        typesTV.delegate = self
        
    }
}
extension TypesMovies: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.tag = test[indexPath.row].self
        return cell
        
    }
    
    
}
