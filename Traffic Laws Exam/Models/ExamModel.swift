//
//  ExamModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit
import CoreData

@objc(ExamModel)
class ExamModel: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var tests: [TestModel]
    @NSManaged var score: Int
    @NSManaged var totalTime: Int
    @NSManaged var datePassed: Date

}
