//
//  EditViewController.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 12/5/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    
    
    @IBOutlet weak var image: UIImageView!
    var index = 0
    var meme = MemeModel.model
    
    //Gets image corresponing to the index of the cell that was pressed
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = meme.getMemeImage(index)
    }
    
    //Segue to ImageMemeController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editMeme" {
            let controller = segue.destination as! ImageMemeController
            controller.index = index
            
        }
    }
    
    
    
    
    

   

}
