//
//  API Manager.swift
//  AppStore
//
//  Created by Muslim on 12.04.2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func fetchSearchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Failed to fetch apps:", error)
                completion([], nil)
                return
            }
            
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
                
            } catch let jsonError {
                print("Failed to decode json:", jsonError)
                completion([], jsonError)
            }
        }.resume()
    }
    
    func fetchApps(completion: @escaping (AppResutls?, Error?) -> ()) {
        
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json")
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil , error)
                return
            }
            
            do {
                let appResults = try JSONDecoder().decode(AppResutls.self, from: data!)
//                print(data)
                appResults.feed.results.forEach({print($0.name)})
                completion(appResults, nil)
            } catch {
                completion(nil, error)
//                print("Failed to decode:", error)
            }
        }.resume()
    }
}
