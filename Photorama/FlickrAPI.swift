//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Aaron Williamson on 2/25/16.
//  Copyright © 2016 Aaron Williamson. All rights reserved.
//

import Foundation

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    
    private static func flickrURLComponents(method method: Method, parameters: [String: String]?) -> NSURL? {
        
        guard let components = NSURLComponents(string: baseURLString) else { return nil }
        
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": APIKey
        ]
        
        for (name, value) in baseParams {
            let item = NSURLQueryItem(name: name, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (name ,value) in additionalParams {
                let item = NSURLQueryItem(name: name, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        guard let url = components.URL else { return nil }
        
        return url
    }
    
    static func photosFromJSONData(data: NSData) -> PhotosResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            guard let jsonDictionary = jsonObject as? [NSObject: AnyObject],
                      photos = jsonDictionary["photos"] as? [String: AnyObject],
                photosArray = photos["photo"] as? [[String: AnyObject]] else {
                // The JSON structure doesn't match our expectations
                return .Failure(FlickrError.InvalidJSONData)
            }
            var finalPhotos = [Photo]()
            
            return .Success(finalPhotos)
        } catch let error {
            return .Failure(error)
        }
    }
    
    static func recentPhotosURL() -> NSURL? {
        guard let url = flickrURLComponents(method: .RecentPhotos, parameters: ["extras" : "url_h,date_take"]) else { return nil }
        
        return url
    }
    
}