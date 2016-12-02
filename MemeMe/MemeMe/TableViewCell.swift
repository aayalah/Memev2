//
//  TableViewCell.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 11/27/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meme: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(_ img: UIImage, labelText text: String) {
        meme.image = img
        label.text = text
    }
    
    
    
    
    
}
