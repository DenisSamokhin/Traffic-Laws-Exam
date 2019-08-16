//
//  CategoryModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/16/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit
import CoreData

@objc(CategoryModel)
class CategoryModel: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var title: String
}
