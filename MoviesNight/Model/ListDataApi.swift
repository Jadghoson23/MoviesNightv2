//
//  ListDataApi.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 31/12/2023.
//

import Foundation


 struct ListDataApi: Codable{
    let results: [results]
    let page : Int
    let total_pages: Int
}
  struct results: Codable{
        let id: Int
        let title:String
        let poster_path: String
        let release_date: String
    }

