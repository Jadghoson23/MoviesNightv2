//
//  SearchListData.swift
//  MoviesNight
//
//  Created by Jad Ghoson on 21/12/2023.
//

import Foundation


struct SearchListData:Codable{
    let Search: [Search]
}
struct Search:Codable{
    let Title:String
    let Year:String
    let imdbID:String
    let Poster:String
}
