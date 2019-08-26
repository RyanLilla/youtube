//
//  TrendingCell.swift
//  youtube
//
//  Created by Ryan Lilla on 8/22/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
