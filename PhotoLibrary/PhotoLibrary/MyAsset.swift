//
//  MyAsset.swift
//  PhotoLibrary
//
//  Created by vikram singh rajpoot on 03/09/17.
//  Copyright © 2017 vikram singh rajpoot. All rights reserved.
//

import UIKit
import Photos

enum MediaType {
    case gallery
    case camera
}

class MyAsset: PHAsset {
    var  type:MediaType = .gallery
    
}
