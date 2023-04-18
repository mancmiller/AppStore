//
//  SearchResult.swift
//  AppStore
//
//  Created by Muslim on 11.04.2023.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
    
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let artworkUrl100: String 
    let screenshotUrls: [String]
    let formattedPrice: String
    let description: String
    let releaseNotes: String
}
