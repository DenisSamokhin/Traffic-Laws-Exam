//
//  ImageManager.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/22/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func load(image imgName: String) -> UIImage? {
        let img = UIImage(named: "ua_\(imgName)")
        return img
    }
}
