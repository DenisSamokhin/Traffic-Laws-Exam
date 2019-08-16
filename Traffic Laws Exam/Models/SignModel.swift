//
//  SignModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import CoreData

@objc(SignModel)
final class SignModel: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var code: String
    @NSManaged var image: String
    @NSManaged var title: String
    @NSManaged var categoryId: Int
}
