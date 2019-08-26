//
//  Video.swift
//  youtube
//
//  Created by Ryan Lilla on 8/17/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import UIKit

struct Video: Decodable {
    
    let title: String?
    let number_of_views: Int?
    let thumbnail_image_name: String?
    let channel: Channel?
    let duration: Int?
    //    let uploadDate: NSDate?
    
}
