//
//  TableViewCell.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 11/27/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var meme: UIImageView!
    @IBOutlet weak var topLabel: UILabel!

    
    //Sets content of cell
    func setContent(_ img: UIImage, topText tText: String, bottomText bText: String) {
        meme.image = img
        topLabel.text = "\(tText)"
        bottomLabel.text = ".....\(bText)"
    }

    
    
    
}
