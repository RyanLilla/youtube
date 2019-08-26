//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Ryan Lilla on 8/22/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
