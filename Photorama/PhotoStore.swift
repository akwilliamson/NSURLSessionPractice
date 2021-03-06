//
//  PhotoStore.swift
//  Photorama
//
//  Created by Aaron Williamson on 2/25/16.
//  Copyright © 2016 Aaron Williamson. All rights reserved.
//

import UIKit

class PhotoStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion completion: (PhotosResult) -> Void) {
    
        guard let url = FlickrAPI.recentPhotosURL() else { return }
        
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data data: NSData?, error: NSError?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(jsonData)
    }
    
    func fetchImageForPhoto(photo: Photo, completion: (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = NSURLRequest(URL: photoURL)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
            }
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data data: NSData?, error: NSError?) -> ImageResult {
        guard let imageData = data,
                  image = UIImage(data: imageData) else {
            // Couldn't create an image
            if data == nil {
                return .Failure(error!)
            } else {
                return .Failure(PhotoError.ImageCreationError)
            }
        }
        return .Success(image)
    }
    
}