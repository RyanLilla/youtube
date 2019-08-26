//
//  ApiService.swift
//  youtube
//
//  Created by Ryan Lilla on 8/20/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import UIKit

// Class that handles JSON data retrieved to populate each video cell
class ApiService: NSObject {

    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    
    // Gets the data for populating the Home feed
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    // Gets the data for populating the Trending feed
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    // Gets the data for populating the Subscriptions feed
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    // Gets the data for the feed corresponding to the input URL string
    func fetchFeedForUrlString (urlString: String, completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                
                // Sets the data retrieved from the JSON data to a video object array
                let json = try JSONDecoder().decode([Video].self, from: data)
                
                // Ensures it is run on the main thread - See "Code Diagnostics/Main Thread Checker"
                DispatchQueue.main.async {
                    completion(json)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
    }
}
