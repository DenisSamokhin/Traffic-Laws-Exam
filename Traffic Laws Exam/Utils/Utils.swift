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
        struct DefaultButton {
            static var bgColor = UIColor.white
            static var textColor = UIColor.black
        }
        
        struct AnswerButton {
            struct NeutralType {
                static var bgColor = UIColor.orange
                static var textColor = UIColor.white
            }
            
            struct WrongType {
                static var bgColor = UIColor.red
                static var textColor = UIColor.white
            }
            
            struct CorrectType {
                static var bgColor = UIColor.green
                static var textColor = UIColor.white
            }
        }
    }
}

struct Constants {
    struct JSONKeys {
        static var id = "id"
        static var code = "code"
        static var image = "image"
        static var title = "title"
        static var categoryId = "categoryId"
        static var similarSigns = "similarSigns"
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
    
    struct Settings {
        static var maxTestsCountInExam = 15
        static var maxAnswersCountInTest = 3
        static var delayBetweenTests = 3.0 // Minimum value - 3.0 sec
        static var correctAnswerHighlightDuration = 2.0
    }
}
