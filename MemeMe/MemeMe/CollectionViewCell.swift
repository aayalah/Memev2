//
//  CollectionViewCell.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 11/27/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    //sets content of cell
    func setContent(_ img: UIImage) {
        image.image = img
    }
    
    
    
    
    
    
}
