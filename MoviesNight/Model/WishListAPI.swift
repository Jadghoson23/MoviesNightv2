//
//  WishListAPI.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 27/01/2024.
//

import Foundation

struct WishListAPI: Codable{
    let id: Int
    let imdb_id:String
    let original_title:String
    let poster_path:String
}
