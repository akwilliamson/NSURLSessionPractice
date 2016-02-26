//
//  PhotoResult.swift
//  Photorama
//
//  Created by Aaron Williamson on 2/26/16.
//  Copyright © 2016 Aaron Williamson. All rights reserved.
//

import Foundation

enum PhotosResult {
    
    case Success([Photo])
    case Failure(ErrorType)
    
}

enum FlickrError: ErrorType {

    case InvalidJSONData

}