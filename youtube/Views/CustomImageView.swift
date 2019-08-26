////
////  CustomImageView.swift
////  youtube
////
////  Created by Ryan Lilla on 8/22/19.
////  Copyright © 2019 Ryan Lilla. All rights reserved.
////
//
//import UIKit
//
//// Creates a cache for storing video iamges locally
//let imageCache = NSCache<AnyObject, AnyObject>()
//
//// Custom class for getting video images based on whether or not the image is in the cache already
//class CustomImageView: UIImageView {
//    
//    var imageUrlString: String?
//    
//    func loadImageUsingUrlString(urlString: String) {
//        
//        imageUrlString = urlString
//        
//        let url = URL(string: urlString)
//        
//        image = nil
//        
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            // Ensures it is run on the main thread - See "Code Diagnostics/Main Thread Checker"
//            DispatchQueue.main.async(execute: {
//                let imageToCache = UIImage(data: data!)
//                
//                if self.imageUrlString == urlString {
//                    self.image = imageToCache
//                }
//                
//                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
//            })
//        }).resume()
//    }
//}
