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
    
    func parseSampleData() {
        parseSignsData()
        parseCategoriesData()
    }
    
    func parseSignsData() {
        guard let signsUrl = Bundle.main.url(forResource: "signs", withExtension: "json") else { return }
        do {
            let jsonData = try Data(contentsOf: signsUrl)
            let arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [AnyObject]
            for object in arr {
                guard let obj = object as? [String : AnyObject],
                    let idNum = obj[Constants.JSONKeys.id] as? NSNumber,
                    let code = obj[Constants.JSONKeys.code] as? String,
                    let image = obj[Constants.JSONKeys.image] as? String,
                    let title = obj[Constants.JSONKeys.title] as? String,
                    let categoryId = obj[Constants.JSONKeys.categoryId] as? NSNumber
                    else { continue }
                let sign = SignModel(context: cdManager.mainManagedObjectContext)
                sign.id = idNum.intValue
                sign.code = code
                sign.image = image
                sign.title = title
                sign.categoryId = categoryId.intValue
                do {
                    try cdManager.mainManagedObjectContext.save()
                }catch {
                    print("Core Data save error")
                }
            }
        }catch {
            
        }
    }
    
    func parseCategoriesData() {
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
    
    func getSignsList() -> [SignModel] {
        return cdManager.getSignsList()
    }
    
    func getCategoriesList() -> [CategoryModel] {
        return cdManager.getCategoriesList()
    }
    
    // MARK: - Exams
    
    func createEmptyExam() -> ExamModel {
        // Calculate id for new exam object and set it
        let exam = ExamModel(context: cdManager.mainManagedObjectContext)
        return exam
    }
    
    
}
