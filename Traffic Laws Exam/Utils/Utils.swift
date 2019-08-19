//
//  Utils.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/12/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import UIKit

struct ButtonSettings {
    struct Colors {
        static var DefaultBgColor = UIColor.white
        static var DefaultTextColor = UIColor.black
    }
}

struct Constants {
    struct JSONKeys {
        static var id = "id"
        static var code = "code"
        static var image = "image"
        static var title = "title"
        static var categoryId = "categoryId"
    }
    
    struct CoreDataKeys {
        static var signs = "SignModel"
        static var exams = "Exams"
        static var categories = "Categories"
        static var profiles = "Profiles"
    }
    
    struct ButtonTitles {
        static var allCategories = "Все категории"
    }
    
    struct ImageNames {
        static var allCategoriesImage = ""
    }
}
