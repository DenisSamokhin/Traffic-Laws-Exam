//
//  CategoryViewModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/16/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import UIKit

struct CategoriesViewModel {
    
    private var categoriesList: [CategoryModel]
    
    
    init(models: [CategoryModel]) {
        categoriesList = models
    }
    
    var categoriesTitles: [String]? {
        var list = [String]()
        for model in self.categoriesList {
            list.append(model.title)
        }
        return list
    }
    
    var categoriesImages: [String]? {
        var list = [String]()
        for model in self.categoriesList {
            list.append(model.title)
        }
        return list
    }
    
    func getID(index: Int) -> Int {
        if index >= categoriesList.count {
            return 0 // if category_id is 0, then show all categories
        }
        let model = categoriesList[index]
        return model.id
    }
}
