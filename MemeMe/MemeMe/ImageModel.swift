//
//  ImageModel.swift
//  MemeMe
//
//  Created by Alejandro Ayala-Hurtado on 11/10/16.
//  Copyright © 2016 MobileApps. All rights reserved.
//

import Foundation
import UIKit

//Uses Singleton pattern to instantiate one instance of MemeModel for all view controllers
class MemeModel {
    
    private var imageList = [ImageModel]()
    
    static let model = MemeModel()
    
    struct ImageModel {
        let topLabel: String
        let bottomLabel: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    func addImage(topLabel top: String, bottomLabel bottom: String, originalImage oImage: UIImage, memedImage meme: UIImage) {
        imageList.append(ImageModel(topLabel: top, bottomLabel: bottom, originalImage: oImage, memedImage: meme))
        
    }
    
    func replaceImage(topLabel top: String, bottomLabel bottom: String, originalImage oImage: UIImage, memedImage meme: UIImage, index: Int){
        imageList[index] = ImageModel(topLabel: top, bottomLabel: bottom, originalImage: oImage, memedImage: meme)
    }
    
    func getMemeImage(_ index: Int) -> UIImage {
        return imageList[index].memedImage
    }
    
    func getTopLabel(_ index: Int) -> String {
        return imageList[index].topLabel
    }
    
    
    func getBottomLabel(_ index: Int) -> String {
        return imageList[index].bottomLabel
    }
    
    func getCount() -> Int {
        return imageList.count
    }
    
    func getOriginalImage(_ index: Int) -> UIImage {
        return imageList[index].originalImage
    }
}
