//
//  PhotoStore.swift
//  Photorama
//
//  Created by Aaron Williamson on 2/25/16.
//  Copyright © 2016 Aaron Williamson. All rights reserved.
//

import Foundation

class PhotoStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentPhotos() {
    
        guard let url = FlickrAPI.recentPhotosURL() else { return }
        
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let jsonData = data {
                do { let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    print(jsonObject)
                } catch let error {
                    print("Error creating JSON object: \(error)")
                }
            } else if let requestError = error {
                print("Error fetching recent photos: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
}