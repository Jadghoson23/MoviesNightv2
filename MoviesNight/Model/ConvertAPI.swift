//
//  ConvertAPI.swift
//  MoviesNight-choose your movie
//
//  Created by Jad Ghoson on 25/01/2024.
//

import Foundation
struct ConvertAPI:Codable{
    let movie_results: [movie_results]
}
struct movie_results: Codable{
    let id: Int
}
