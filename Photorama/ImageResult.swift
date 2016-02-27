//
//  ImageResult.swift
//  Photorama
//
//  Created by Aaron Williamson on 2/26/16.
//  Copyright © 2016 Aaron Williamson. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum PhotoError: ErrorType {
    case ImageCreationError
}
