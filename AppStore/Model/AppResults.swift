//
//  AppResult.swift
//  AppStore
//
//  Created by Muslim on 16.04.2023.
//

import Foundation

struct AppResutls: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
