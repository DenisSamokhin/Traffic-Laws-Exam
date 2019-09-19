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
    
    var categoriesTitles: [String] {
        var list = [String]()
        for model in self.categoriesList {
            list.append(model.title)
        }
        // Add "All categories" option
        list.append(Constants.ButtonTitles.allCategories)
        return list
    }
    
    var categoriesImages: [String] {
        var list = self.categoriesList.map({$0.image})
        // Add image name for "All categories" option
        list.append(Constants.ImageNames.allCategoriesImage)
        return list
    }
    
    func getID(index: Int) -> Int {
        if index >= 0 && index < categoriesList.count {
            let model = categoriesList[index]
            return model.id
        }else {
            return 0 // id for  "All categories" option
        }
        
    }
}
