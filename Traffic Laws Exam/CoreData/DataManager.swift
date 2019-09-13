//
//  DataManager.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let cdManager = CoreDataManager.init(modelName: "Traffic_Laws_Exam")
    
    private init(){}
    
    func saveData() {
        guard let context = cdManager.mainManagedObjectContext.parent else { return }
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func parseSampleData() {
        parseSignsData()
        parseCategoriesData()
    }
    
    private func parseSignsData() {
        guard let signsUrl = Bundle.main.url(forResource: "signs", withExtension: "json") else { return }
        do {
            let jsonData = try Data(contentsOf: signsUrl)
            let arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [AnyObject]
            for object in arr {
                guard let obj = object as? [String : AnyObject],
                    let idNum = obj[Constants.JSONKeys.id] as? NSNumber,
                    let code = obj[Constants.JSONKeys.code] as? String,
                    let title = obj[Constants.JSONKeys.title] as? String,
                    let categoryId = obj[Constants.JSONKeys.categoryId] as? NSNumber
                    else { continue }
                let sign = SignModel(context: cdManager.mainManagedObjectContext)
                sign.id = idNum.intValue
                sign.code = code
                sign.image = code
                sign.title = title
                sign.categoryId = categoryId.intValue
                sign.similarSigns = obj[Constants.JSONKeys.similarSigns] as? [Int]
                if sign.similarSigns == nil {
                    print("-\n----- DATA SAMPLE ERROR: Similar Signs are missing for sign with ID: \(sign.id) and Title: \(sign.title)")
                }
                do {
                    try cdManager.mainManagedObjectContext.save()
                }catch {
                    print("Core Data save error")
                }
            }
        }catch {
            
        }
    }
    
    private func parseCategoriesData() {
        guard let categoryUrl = Bundle.main.url(forResource: "categories", withExtension: "json") else { return }
        do {
            let jsonData = try Data(contentsOf: categoryUrl)
            let arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [AnyObject]
            for object in arr {
                guard let obj = object as? [String : AnyObject],
                    let idNum = obj[Constants.JSONKeys.id] as? NSNumber,
                    let title = obj[Constants.JSONKeys.title] as? String
                    else { continue }
                let category = CategoryModel(context: cdManager.mainManagedObjectContext)
                category.id = idNum.intValue
                category.title = title
                do {
                    try cdManager.mainManagedObjectContext.save()
                }catch {
                    print("Core Data save error")
                }
            }
        }catch {
            
        }
    }
    
    // MARK: - Getters
    
    func getSignsList(categoryId: Int?) -> [SignModel] {
        return cdManager.getSignsList(categoryId: categoryId)
    }
    
    func getCategoriesList() -> [CategoryModel] {
        return cdManager.getCategoriesList()
    }
    
    func getSign(id: Int) -> SignModel? {
        return cdManager.getSign(id: id)
    }
    
    // MARK: - Exams
    
    func createEmptyExam() -> ExamModel {
        // Calculate id for new exam object and set it
        let exam = ExamModel(context: cdManager.mainManagedObjectContext)
        exam.id = cdManager.newId(for: Constants.CoreDataKeys.exams)
        return exam
    }
    
    
    func saveExam(exam: ExamModel) {
        do {
            try cdManager.mainManagedObjectContext.save()
        }catch {
            print("Core Data save error")
        }
    }
    
}
