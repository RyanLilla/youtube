//
//  BaseCell.swift
//  youtube
//
//  Created by Ryan Lilla on 8/17/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
