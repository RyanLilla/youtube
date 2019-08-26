//
//  VideoCell.swift
//  youtube
//
//  Created by Ryan Lilla on 8/16/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: BaseCell {
    
    // Constraint for how the title label is adjusted based on size
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    // Creates a complete video object, and sets the display size and contents for the cell
    var video: Video? {
        didSet {
            
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let SubtitleText = "\(channelName) • \(numberFormatter.string(from: NSNumber(integerLiteral: numberOfViews))!) • 2 years ago"
                subtitleTextVIew.text = SubtitleText
            }
            
            // Measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
                
                // Determines if the title label size should be adjusted
                // to account for titles that are longer than 1 line in length
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                }
                else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    // Sets up the channel's profile image
    func setupProfileImage() {
        if let profileImageURL = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL)
        }
    }
    
    // Sets up the video's thumbnail image
    func setupThumbnailImage() {
        if let thumbnailImageURL = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageURL)
        }
    }
    
    // Creates the constraints for how the thumbnail image should look
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        
        // Scales the image to its' full size while preserving the aspect ratio
        imageView.contentMode = .scaleAspectFill
        
        // Clips the image so that it fits between the view's boundaries
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    // Creates the constraints for how the channel's profile image should look
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        
        // Creates a circular image
        imageView.layer.cornerRadius = 22
        
        // Allows the image to be clipped if it goes outside the bounds
        imageView.layer.masksToBounds = true
        
        // Scales the image to its' full size while preserving the aspect ratio
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // Creates a 'separator' line in between each video in the collection
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return view
    }()
    
    // Sets up the title label
    let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        
        return label
    }()
    
    // Sets up the subtitle textview
    let subtitleTextVIew: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 132,611,324 views • 2 years ago"
        
        // Adjusts where the text sits in the text view
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        
        return textView
    }()
    
    // Sets up the views for a single video cell
    override func setupViews() {
        
        // Adds the thumbnail image to the collectionViewCell
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextVIew)
        
        // Adds contraints for how the thumbnail and channel profile views will be displayed
        addContraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addContraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        // Vertical contraints
        addContraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addContraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        
        // Title constraint - Top
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // Title constraint - Left
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Title constraint - Right
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Title constraint - Height
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        
        // Subtitle constraint - Top
        addConstraint(NSLayoutConstraint(item: subtitleTextVIew, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        // Subtitle constraint - Left
        addConstraint(NSLayoutConstraint(item: subtitleTextVIew, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        // Subtitle constraint - Right
        addConstraint(NSLayoutConstraint(item: subtitleTextVIew, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // Subtitle constraint - Height
        addConstraint(NSLayoutConstraint(item: subtitleTextVIew, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}

extension UIView {
    
    // Handles the formatting for the subviews within the collection cells
    func addContraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            // Ensures it is run on the main thread - See "Code Diagnostics/Main Thread Checker"
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            })
        }).resume()
    }
}
