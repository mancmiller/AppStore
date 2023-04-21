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
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let artworkUrl100: String 
    let screenshotUrls: [String]
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
}
